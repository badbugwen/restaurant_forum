class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  def index
  end

end
