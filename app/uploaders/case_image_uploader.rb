class CaseImageUploader < CarrierWave::Uploader::Base
  storage ENV["FILE_STORAGE"].to_sym 
  def store_dir
    "case_images/#{model.id}"
  end
end