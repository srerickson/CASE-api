class CreateEvaluationSets < ActiveRecord::Migration
  def self.up
    create_table :evaluation_sets do |t|
      t.string  :name
      t.string  :param
      t.text    :description
      t.integer :user_id
      t.boolean :locked, default: false
      t.boolean :public_responses, default: true
      t.timestamps
    end

    create_table :evaluation_questions do |t|
      t.string  :type
      t.integer :evaluation_set_id
      t.integer :position
      t.text    :question
      t.json    :response_options, default: {}
      t.boolean :is_subquestion, default: false
      t.timestamps
    end

    create_table :evaluation_responses do |t|
      t.integer :user_id
      t.integer :evaluation_question_id
      t.integer :case_id
      t.json    :answer, default: {}
      t.text    :comment 
    end
  end

  def self.down
    drop_table :evaluation_sets
    drop_table :evaluation_questions
    drop_table :evaluation_responses
  end
end
