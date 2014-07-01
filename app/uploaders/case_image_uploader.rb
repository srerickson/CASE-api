
class CaseImageUploader < CarrierWave::Uploader::Base
  
  include CarrierWave::MiniMagick

  storage ENV["FILE_STORAGE"].to_sym 

  def store_dir
    "case_images/#{model.id}"
  end

  version :sq100 do
    process :resize_to_fit => [100,100]
  end

  version :sq60 do
    process :resize_to_fit => [60,60]
  end

end