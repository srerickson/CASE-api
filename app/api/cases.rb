class CasesAPI < Grape::API

  helpers AuthorizationHelpers

  namespace :cases do

    # before do 
    #   authenticate!
    # end

    desc "List Cases"
    get do 
      Case.all
    end

    desc "Creates a new Case"
    post do 
      Case.create(params[:case])
    end

    route_param :id do 

      desc "Show Case"
      get do
        Case.find(params[:id])
      end

      desc "Updates a Case"
      put do
        Case.find(params[:id]).update_attributes(params[:case])
      end

      desc "Destroys a Case"
      delete do
        Case.find(params[:id]).destroy()
      end

      #
      # NESTED FIELD VALUES
      #
      namespace :field_values do

        desc "List Cases Field Values"
        get do 
          Case.find(params[:id]).field_values
        end

        desc "Creates a new Field Value in the Case"
        post do 
          Case.find(params[:id])
            .field_values.create(params[:field_value])
        end

        route_param :field_value_id do

          desc "Updates a Field Value in the Case"
          put do
            Case.find(params[:id])
              .field_values.find(params[:field_value_id])
              .update_attributes(params[:field_value])
          end

          desc "Destroys a Field Value in the Case"
          delete do 
            Case.find(params[:id])
              .field_values.find(params[:field_value_id])
              .destroy()
          end

        end

      end # namespace :field_values
    end # route_param :id
  end # namespace :cases


end
