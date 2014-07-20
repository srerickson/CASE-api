class Upload < ActiveRecord::Base

  mount_uploader :asset, AssetUploader

  belongs_to :parent, polymorphic: true, inverse_of: :uploads

  belongs_to :uploaded_by, class_name: "::User"

  def image_and_not_svg?
    content_type and content_type.start_with? 'image' and content_type !~ /\/svg\+xml/
  end

end