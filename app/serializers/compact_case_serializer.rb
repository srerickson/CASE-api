class CompactCaseSerializer < ActiveModel::Serializer
  
  attributes  :id, 
              :name, 
              :description,
              :created_at,
              :updated_at,
              :_image_urls

  def _image_urls
    {
      sq60: object.image.url(:sq60),
      sq100: object.image.url(:sq100)

    }
  end           

end