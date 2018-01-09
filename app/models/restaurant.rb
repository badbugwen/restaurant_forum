class Restaurant < ApplicationRecord
  mount_uploader :image, PhotoUploader
  has_many :comments, dependent: :destroy
  belongs_to :category, optional: true

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
end
