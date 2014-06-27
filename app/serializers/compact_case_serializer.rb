class CompactCaseSerializer < ActiveModel::Serializer
  
  attributes  :id, 
              :name, 
              :description,
              :created_at,
              :updated_at,
              :image_url

  def image_url
    object.image.url
  end           

end