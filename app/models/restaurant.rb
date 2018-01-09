class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  def index
  end
  has_many :comments, dependent: :destroy
  belongs_to :category, optional: true
end
