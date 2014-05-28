$:.unshift("./app","./app/api","./libs")

require "grape"
require "api/api"

desc "API Routes"
task :routes do
  ::API.routes.each do |api|
    method = api.route_method.ljust(10)
    path = api.route_path
    puts "     #{method} #{path}"
  end
end