class API < Grape::API

  format :json

  before do
    header "Access-Control-Allow-Origin", "*"
  end


  get "/schemas" do
    Schema.all
  end

  post "/schemas" do 
    puts params[:schema]
    Schema.create! params[:schema]
  end

  # post "/" do
  #   # All parameters will be stored in the model
  #   puts params
  #   thing = Thing.new(name: params[:name])
  #   if thing.save
  #     { thingId: thing.id }
  #   else
  #     error!({ errors: thing.errors.messages }, 403)
  #   end
  # end

end