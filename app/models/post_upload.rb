class PostUpload < ActiveRecord::Base
  mount_uploader :image, ImageUploader
end
