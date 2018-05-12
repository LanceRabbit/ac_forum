class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # 發表文章
  has_many :posts, dependent: :destroy
  # 回覆文章
  has_many :replies, dependent: :destroy
  
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  #透過Friendship的foreign_key取得追隨者的資料
  has_many :self_friends, class_name: "Friendship", foreign_key: "friend_id", dependent: :destroy
  
  ROLE = { 
       'normal': 'normal',
       'admin': 'admin'
      } 

  def admin?
    self.role == "admin"
  end
end
