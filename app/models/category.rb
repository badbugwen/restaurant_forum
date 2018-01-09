class Category < ApplicationRecord
  validates_presence_of :name

  # 如果該類別已經有了餐廳，就不允許刪除類別（刪除時拋出 Error）
  has_many :restaurants, dependent: :restrict_with_error
end
