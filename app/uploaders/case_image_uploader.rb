class CaseImageUploader < CarrierWave::Uploader::Base
  def store_dir
    "case_images/#{model.id}"
  end
  storage :file
end