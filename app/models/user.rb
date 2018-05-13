class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # 發表文章
  has_many :posts, dependent: :destroy
  # 回覆文章
  has_many :replies, dependent: :destroy

  # 收藏
  has_many :collections, dependent: :destroy
  # user 收藏很多文章
  # 避免與其他命名混肴,collected_posts
  # 需另加 source 告知 Model name(指定 Model name，慣例使用單數)
  has_many :collected_posts, through: :collections, source: :post

  has_many :friendships, dependent: :destroy
  has_many :friendships_invitees, class_name:'User', through: :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :friendships_inviters, class_name:'User', through: :inverse_friendships

  ROLE = { 
       'normal': 'normal',
       'admin': 'admin'
      } 


  def inviter_friend?(user)
    self.friendships_inviters.include?(user)
  end

  def invitee_friend?(user)
    self.friendships_invitees.include?(user)
  end

  def friends
    self.friendships_invitees.where('status = ? ',true)
  end

  def invitee_friends
    self.friendships_invitees.where('status = ? ',false)
  end

  def inviter_friends
    self.friendships_inviters.where('status = ? ',false)
  end

  def is_friend?(user)
    self.friends.include?(user)
  end
        
  def admin?
    self.role == "admin"
  end
end
