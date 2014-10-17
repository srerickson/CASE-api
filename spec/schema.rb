require "spec_helper"

describe "Schema" do
  before :each do
    @schema = Schema.new(name: 'testing', param: 'testing')
  end

  it "should be valid with correct values" do
    @schema.should be_valid
  end

  it "should not be valid with undefined layout fields" do
    @schema.layout = [{'field_definitions' => ['doesnt_exist']}]
    @schema.valid?
    @schema.errors[:layout].should include("includes fields that aren't part of the schema: doesnt_exist")
  end

  it "should not be valid with duplicate fields in layout" do
    @schema.layout = [{'field_definitions' => ['nope','nope']}]
    @schema.valid?
    @schema.errors[:layout].should include("includes duplicate fields: nope")
  end


end