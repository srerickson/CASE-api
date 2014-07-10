module CASE
  module Evaluations
    class Question < ActiveRecord::Base
      belongs_to :set, inverse_of: :questions,
                       class_name: '::CASE::Evaluations::Set'

      has_many :responses, dependent: :destroy, 
                           inverse_of: :question,
                           class_name: '::CASE::Evaluations::Response'



      # Response aggregates use these params
      # in count fields - e.g. "n_a_count"
      def response_option_params
        Hash[ response_options.map{|k,v| [k, v.parameterize.underscore]} ]
      end

    end
  end
end