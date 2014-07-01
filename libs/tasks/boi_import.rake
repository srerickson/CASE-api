require 'json'

CASE_FILES =  Rake::FileList.new("../seven-dimensions-of-participation/birds/*.json")
SCHEMA_FILE = "boi_schema.json"

namespace :boi_import do 

  task :users => :environment do 
    User.create(name:"Seth", email:"sr.erickson@gmail.com", password:"12345")
  end


  task :schema => [:environment, SCHEMA_FILE] do 
    schema_params = JSON.parse IO.read(SCHEMA_FILE)
    if existing = Schema.find_by(param: schema_params["schema"]["param"])
      existing.destroy
    end
    Schema.create!(schema_params["schema"])
  end


  task :cases => [:environment]+CASE_FILES do
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
  end


end