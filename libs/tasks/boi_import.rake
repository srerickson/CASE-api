require 'json'

CASE_FILES =  Rake::FileList.new("../seven-dimensions-of-participation/birds/*.json")
SCHEMA_FILE = "boi_schema.json"

EVAL_SET_FILE = File.expand_path("../seven-dimensions-of-participation/evaluation_sets/1.json")
EVAL_RESP_FILES = Rake::FileList.new("../seven-dimensions-of-participation/evaluation_sets/evaluation_answers/*.json")

USERS_FILE = File.expand_path("../seven-dimensions-of-participation/users.json")

CASE_ID_MAP_FILE = "tmp/boi_import-case_id_map.json"
USER_ID_MAP_FILE = "tmp/boi_import_user_id_map.json"


namespace :boi_import do 

  task :users => :environment do 
    users_map = {}
    old_users = JSON.parse IO.read(USERS_FILE)
    old_users.each do |u|
      puts u
      new_user = User.find_or_initialize_by(email: u["email"])
      new_user.password = 'birds'
      new_user.name = u["email"].split("@")[0]
      new_user.save! 
      users_map[u["id"]] = new_user.id 
    end

    File.open(USER_ID_MAP_FILE,'w') do |f|
      f.write JSON.pretty_generate(users_map)
    end
  end


  task :schema => [:environment, SCHEMA_FILE] do 
    schema_params = JSON.parse IO.read(SCHEMA_FILE)
    if existing = Schema.find_by(param: schema_params["schema"]["param"])
      existing.destroy
    end
    Schema.create!(schema_params["schema"])
  end


  task :cases => [:environment]+CASE_FILES do

    case_id_map = {}

    CASE_FILES.each do |c_file|
      old_case = JSON.parse IO.read(c_file)
      puts "-- Considering #{old_case['name']} --"
      new_case = Case.find_or_initialize_by(name: old_case["name"])

      if new_case.new_record? 
        new_case.save
        new_case.reload
        puts "...[+] created new case"
      else
        puts "...[-] case already exists "
      end

      case_id_map[old_case["id"].to_s] = new_case.id 

      if old_case["logo"]
        if !new_case.image?
          new_case.remote_image_url = "http://birds.recursivepublic.net/"+old_case["logo"]
          new_case.save!
          puts "...[+] uploaded logo"
        else
          puts "...[-] logo already uploaded"
        end
      else
        puts "...[-] no logo"
      end
      old_case.delete("name")
      old_case.delete("logo")

      # values we don't migrate. 
      old_case.delete("id")
      old_case.delete("thumbnail_100_url")
      old_case.delete("thumbnail_50_url")
      old_case.delete("created_at")
      old_case.delete("updated_at")
      old_case.delete("updated_by")

      #attached images 
      old_case["images"].each do |img|
        file_name = img["url"].split('/')[-1].split('?')[0]
        if new_case.uploads.where(asset: file_name).empty?
          url = "http://birds.recursivepublic.net/"+img["url"]
          new_case.uploads.create(remote_asset_url: url)
          puts "...[+] uploaded #{file_name}"
        else
          puts "...[-] already uploaded #{file_name}"
        end
      end
      old_case.delete("images")

      skipped_keys = []
      old_case.keys.each do |k|
        if fd = FieldDefinition.find_by(param: k)
          fv = fd.class.value_class.find_or_initialize_by(case_id: new_case.id, field_definition_id: fd.id)
          begin
            if fv.is_a? SelectValue
              if k == "tangible_problem" # special case
                fv.value = fd.option_id_by_name(old_case[k])
              else
                fv.value = old_case[k].nil? ? nil : fd.option_id_by_name(old_case[k]["name"])
              end
            else 
              fv.value = old_case[k]
            end
          rescue StandardError => e
            puts "failed on #{new_case.id} - #{k}: #{e}"
            puts "value was: #{old_case[k]}"
            raise e 
          end
          fv.save
        else
          skipped_keys << k
        end
      end
      unless skipped_keys.empty?
        puts "... skipped values for: #{skipped_keys.join(',')} "
      end
    end

    File.open(CASE_ID_MAP_FILE, 'w') do |f|
      f.write(JSON.pretty_generate( case_id_map) )
    end

  end


  task :evaluations => [:environment, EVAL_SET_FILE] + EVAL_RESP_FILES do

    include CASE::Evaluations 

    case_id_map = JSON.parse IO.read(CASE_ID_MAP_FILE)
    user_id_map = JSON.parse IO.read(USER_ID_MAP_FILE)

    # maps old->new question ids
    eval_question_map = {}

    # old eval questions don't have params
    params_map = {
      1 => "educative",
      2 => "goals",
      3 => "direct",
      4 => "control",
      5 => "collective",
      6 => "exit",
      7 => "voice",
      8 => "metrics",
      9 => "communication"
    }

    # clear everything
    CASE::Evaluations::Set.destroy_all 

    # create the evaluation set
    new_eval_set = CASE::Evaluations::Set.create(name: "BOI Summer 2012", locked: true, public_responses: true)
    old_eval_set = JSON.parse IO.read(EVAL_SET_FILE)
    eval_questions = old_eval_set["evaluation_questions"]
    eval_questions.each do |q|
      new_q = new_eval_set.questions.create({
        question: q["question"], 
        order: q["position"], 
        param: params_map[q["id"]],
        is_subquestion: q['sub_question'],
        response_options: {
          "-1" => "NO",
          "0"  => "N/A",
          "1"  => "YES"
        }
      })
      eval_question_map[q["id"].to_s] = new_q.id
    end

    new_answer_map = {
      "NO"  => -1,
      "N/A" => 0,
      "YES" => 1
    }

    #migrate the responses
    EVAL_RESP_FILES.each do |f|
      # each file has responses for a particular case/question pair
      resp_group = JSON.parse IO.read(f)
      resp_group.each do |resp|
        CASE::Evaluations::Response.create!(
          question_id: eval_question_map[resp['evaluation_question_id'].to_s],
          case_id: case_id_map[resp['bird_id'].to_s],
          answer: new_answer_map[resp['answer']],
          comment: resp['comment'],
          user_id: user_id_map[resp['user_id'].to_s]
        )
      end

    end

  end



end