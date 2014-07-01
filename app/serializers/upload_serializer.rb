class UploadSerializer < ActiveModel::Serializer

  attributes  :id,
              :_urls, 
              :content_type,
              :file_size,
              :width, 
              :height, 
              :caption

  # has_one :uploaded_by, serializer: UserSerializer

  def _urls
    {
      original: object.asset.url,
      sq60: object.asset.url(:sq60)
    }
  end


end