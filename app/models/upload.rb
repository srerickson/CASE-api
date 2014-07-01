class Upload < ActiveRecord::Base

  mount_uploader :asset, AssetUploader

  belongs_to :parent, polymorphic: true, inverse_of: :uploads

end