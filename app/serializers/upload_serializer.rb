class UploadSerializer < ActiveModel::Serializer

  attributes  :id,
              :filename,
              :_urls, 
              :content_type,
              :file_size,
              :width, 
              :height, 
              :caption
              :created_at
              
  has_one :uploaded_by

  # has_one :uploaded_by, serializer: UserSerializer

  def filename
    File.basename(object.asset.path)
  end

  def _urls
    ret = {}
    ret[:original] = object.asset.url

    if object.image_and_not_svg? 
      ret[:sq60] = object.asset.url(:sq60)
      # ret[:sq120] = object.asset.url(:sq120)
    end

    ret

  end


end