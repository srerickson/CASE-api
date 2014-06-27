$:.unshift("./")

require 'environment.rb'

require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :put, :delete]
  end
end

use Rack::Static, urls: ["/case_images"], root: "public"

run CASE::API