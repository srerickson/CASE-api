class FieldDefinition < ActiveRecord::Base

  belongs_to :field_set, inverse_of: :field_definitions
  
  has_many :field_values, inverse_of: :field_definition

  validates_presence_of :name, :param, :field_set


  #
  # Instance methods helpers for selection FieldDefinitions
  #


  # return the id of the select option with the given name
  def select_lookup_id_by_name(name)
    return nil if value_type != "select"
    begin 
      option = value_options["select"].detect{|s| s["name"] == name }
      option["id"]
    rescue StandardError => e
      nil 
    end
  end

end