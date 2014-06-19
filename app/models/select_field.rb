class SelectField < FieldDefinition 

  # return the id of the select option with the given name
  def option_id_by_name(name)
    begin 
      option = value_options["select"].detect{|s| s["name"] == name }
      option["id"]
    rescue StandardError => e
      nil 
    end
  end


  def self.value_class
    SelectValue
  end

end