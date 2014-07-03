module CASE
  module Evaluations
    class Response < ActiveRecord::Base
      belongs_to :user
      belongs_to :case #kase?
      belongs_to :question, class_name: '::CASE::Evaluations::Question'
      validates_presence_of :case, :question #, :user
    end
  end
end