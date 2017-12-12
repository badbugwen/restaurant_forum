class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  def index
  end
  belongs_to :category
end
