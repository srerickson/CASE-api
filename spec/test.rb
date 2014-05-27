require "spec_helper"

class Schema
  include Mongoid::Document
  embeds_many :field_sets 
end

class FieldSet
  include Mongoid::Document  
  embedded_in :schema
  embeds_many :field_definitions
end

class FieldDefinition
  include Mongoid::Document
  field :name, type: String 
  embedded_in :field_set 
end

describe "Update to Schema Field Definitions" do
  before :each do
    Schema.delete_all
    schema = Schema.create

    # Three initial field sets
    3.times do 
        schema.field_sets << FieldSet.new
    end

    # One initial field definition in the last field set
    schema.field_sets.last.field_definitions.create(name:"testing")

    # IDs used to recall field def for update (mimicking API params)
    @schema_id    = schema._id.to_s 
    @field_set_id = schema.field_sets.last._id.to_s 
    @field_def_id = schema.field_sets.last.field_definitions.first._id.to_s 
  end

  it "should not create extra field definitions on update " do

    field_def = Schema.find(@schema_id).field_sets.find(@field_set_id).field_definitions.find(@field_def_id)

    #field_def.name.should eql "testing"

    field_def.name = "updating on testing"
    field_def.save

    Schema.first.field_sets.last.field_definitions.count.should eql 1
  end
end