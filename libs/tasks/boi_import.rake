require 'json'

CASE_FILES =  Rake::FileList.new("../seven-dimensions-of-participation/birds/*.json")

namespace :boi_import do 

  task :cases => [:environment]+CASE_FILES do

    CASE_FILES[0..1].each do |c_file|
      old_case = JSON.parse IO.read(c_file)
      new_case = Case.find_or_create_by(id: old_case["id"], name: old_case["name"])
      skipped_keys = []
      old_case.keys.each do |k|
        if fd = FieldDefinition.find_by(param: k)
          # ... 
        else
          skipped_keys << k
        end
      end
      puts "completed #{old_case["name"]}, skipped: #{skipped_keys.join(',')} "
    end

  end

end