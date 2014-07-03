class CreateEvaluationSets < ActiveRecord::Migration
  def self.up
    create_table :sets do |t|
      t.string  :name
      t.text    :description
      t.integer :user_id
      t.boolean :locked, default: false
      t.boolean :public_responses, default: true
      t.timestamps
    end

    create_table :questions do |t|
      t.string  :type
      t.integer :set_id
      t.integer :position
      t.text    :question
      t.string  :param
      t.json    :response_options, default: {}
      t.boolean :is_subquestion, default: false
      t.timestamps
    end

    create_table :responses do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :case_id
      t.json    :answer, default: {}
      t.text    :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :sets
    drop_table :questions
    drop_table :responses
  end
end
