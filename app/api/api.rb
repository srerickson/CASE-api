class API < Grape::API

  format :json

  before do
    header "Access-Control-Allow-Origin", "*"
  end

  mount ::SchemasAPI
  mount ::FieldSetsAPI

end

