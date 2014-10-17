
#
# Deprecated Model Logic 
#
class FieldSet < ActiveRecord::Base
  belongs_to :schema, inverse_of: :field_sets
  has_many :field_definitions, -> {order(:order)}, inverse_of: :field_set
end
class Schema < ActiveRecord::Base
  has_many :field_sets, -> {order(:order)}, inverse_of: :schema                 
end
class FieldDefinition < ActiveRecord::Base
  belongs_to :field_set, inverse_of: :field_definitions
end
class FieldSetSerializer < ActiveModel::Serializer
  attributes  :name, 
              :param, 
              :description,
              :field_definitions
  def field_definitions
    object.field_definitions.map(&:param)
  end
end



#
# Migration 
#
class RemoveFieldset < ActiveRecord::Migration
  def self.up

    # new columns
    add_column :field_definitions, :schema_id, :integer
    add_column :schemas, :layout, :json

    Schema.reset_column_information 
    FieldDefinition.reset_column_information

    # relate field_definitions to parent schema
    Schema.all.each do |s|
      s.field_sets.each do |fs|
        fs.field_definitions.each do |fd|
          fd.update_attributes(schema_id: s.id)
        end
      end
    end

    # field_sets -> layout json
    Schema.all.each do |s|
      j = ActiveModel::ArraySerializer.new(s.field_sets, each_serializer: FieldSetSerializer).to_json
      s.update_attributes(layout: j)
    end

    # remove un-used tables/columns
    drop_table :field_sets
    remove_column :field_definitions, :field_set_id
    remove_column :field_definitions, :order

  end


  # Rewind: put field_sets back together again
  #
  def self.down

    create_table :field_sets do |t|
      t.integer :schema_id
      t.string  :name
      t.string  :param
      t.text    :description
      t.integer :order
      t.timestamps
    end
    add_column :field_definitions, :field_set_id, :integer
    add_column :field_definitions, :order, :integer

    FieldSet.reset_column_information
    FieldDefinition.reset_column_information

    # layout json -> field sets
    Schema.all.each do |s|
      next if !s.layout.is_a?(Array)
      s.layout.each_with_index do |section,i|
        fs = s.field_sets.create!({
          name: section['name'],
          param: section['param'],
          order: i
        })
        section['field_definitions'].each_with_index do |param,j|
          s.field_definitions
           .find_by_param(param)
           .update_attributes!({
              order: j,
              field_set_id: fs.id
            })
        end
      end
    end

    remove_column :field_definitions, :schema_id
    remove_column :schemas, :layout
  end
end
