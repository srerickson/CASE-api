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

  end
end