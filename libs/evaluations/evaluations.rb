$:.push File.expand_path("../", __FILE__)

module CASE
  module Evaluations

    autoload :API, 'api/api'

    autoload :EvaluationSet,      'models/evaluation_set'
    autoload :EvaluationQuestion, 'models/evaluation_question'
    autoload :EvaluationResponse, 'models/evaluation_response'

    autoload :EvaluationSetSerializer,      'serializers/evaluation_set_serializer'
    autoload :EvaluationQuestionSerializer, 'serializers/evaluation_question_serializer'

  end
end