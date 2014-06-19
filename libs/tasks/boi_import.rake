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
      new_case = Case.find_or_create_by(id: old_case["id"], name: old_case["name"])
      skipped_keys = []
      old_case.keys.each do |k|
        if fd = FieldDefinition.find_by(param: k)
          fv = FieldValue.find_or_initialize_by(case_id: new_case.id, field_definition_id: fd.id)
          begin
            if fd.value_type == "select"
              if k == "tangible_problem" # special case
                fv.value = fd.select_lookup_id_by_name(old_case[k])
              else
                fv.value = old_case[k].nil? ? nil : fd.select_lookup_id_by_name(old_case[k]["name"])
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
      puts "completed #{old_case["name"]}, skipped values for: #{skipped_keys.join(',')} "
    end
  end


end