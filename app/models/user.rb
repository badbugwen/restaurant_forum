class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :name

  mount_uploader :avatar, AvatarUploader

  # 「使用者評論很多餐廳」的多對多關聯
  # 如果 User 已經有了評論，就不允許刪除帳號（刪除時拋出 Error）
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  # 「餐廳被很多使用者收藏」的多對多關聯
  #當 Restaurant 物件被刪除時，順便刪除依賴的 favorite
  # 將關聯名稱自訂為 :favorited_users
  # 自訂名稱後，Rails 無法自動推論來源名稱，需另加 source 告知 model name
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant
  
  # 「餐廳有很多使用者按讚」的多對多關係(模式同"收藏")
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :user

  # 「使用者可以追蹤很多其他使用者」的自關聯
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  # 自關聯的逆向方法:@user可以逆向追蹤follower(設定@user為following的users)
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inviters, through: :inverse_friendships, source: :user


  # admin? 讓我們用來判斷單個user是否有 admin 角色，列如：current_user.admin?
  def admin?
    self.role == "admin" 
  end 

  #判斷該user是否有追蹤指定之(user)
  def following?(user)
    self.followings.include?(user)      
  end    

end
