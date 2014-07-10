$:.push File.expand_path("../", __FILE__)

module CASE
  module Evaluations

    autoload :Set,      'models/set'
    autoload :Question, 'models/question'
    autoload :Response, 'models/response'

    autoload :SetSerializer,      'serializers/set_serializer'
    autoload :CompactSetSerializer, 'serializers/compact_set_serializer'

    autoload :ResponseSerializer, 'serializers/response_serializer'
    autoload :QuestionSerializer, 'serializers/question_serializer'

    autoload :Sets, 'api/sets'
    autoload :Questions, 'api/questions'
    autoload :Responses, 'api/responses'

    class API< Grape::API
      mount CASE::Evaluations::Sets
      mount CASE::Evaluations::Responses
    end

    def self.aggregate(responses, questions = nil)      
      questions ||= Question.all # probably a bad idea
      aggregated = []
      questions.each do |q|
        select  = "case_id, question_id"
        q.response_options.each do |k,v|
          select += ",COUNT( CASE WHEN answer = #{k.to_i} then 1 ELSE null END) as #{v.parameterize.underscore}_count"
          select += ",COUNT( CASE WHEN answer = #{k.to_i} and comment is not null AND comment != '' then 1 ELSE null END) as #{v.parameterize.underscore}_comment_count"
        end
        aggregated += responses.select( select )
                        .where(question_id: q.id)
                        .group("responses.case_id, responses.question_id")
                        # .order('case_id ASC')
      end
      aggregated
    end

  end
end