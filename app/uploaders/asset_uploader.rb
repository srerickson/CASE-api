class AssetUploader < CarrierWave::Uploader::Base
  
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  storage ENV['FILE_STORAGE'].to_sym

  process :set_content_type
  process :save_content_type_and_size_in_model
  process :store_geometry

  version :sq60, :if => :image_and_not_svg? do
    process :resize_to_fit => [60,60]
  end

  version :sq120, :if => :image_and_not_svg? do
    process :resize_to_fit => [120,120]
  end

  def store_dir
    "uploads/#{model.id}"
  end

  def save_content_type_and_size_in_model
    model.content_type = file.content_type if file.content_type
    model.file_size = file.size
  end


  def store_geometry
    if @file and image?(@file)
      img = MiniMagick::Image.open(@file.path)
      if model
        model.height = img['height']
        model.width = img['width']
      end
    end
  end


protected
  
  def image?(new_file)
    new_file.content_type.start_with? 'image'
  end

  def image_and_not_svg?(new_file)
    image?(new_file) and new_file.content_type !~ /\/svg\+xml/
  end


end