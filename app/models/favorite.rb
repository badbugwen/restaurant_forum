class Favorite < ApplicationRecord
  belongs_to :usr
  belongs_to :restaurant
end
