class Friendship < ApplicationRecord
  # 確保特定 user_id 下，只能有一個 friend_id
  validates :friend_id, uniqueness: { scope: :user_id }

  belongs_to :user
  # 預設的外部鍵: friend_id
  belongs_to :friend, class_name: "User" 

  belongs_to :friendships_inviter, class_name:'User', foreign_key:'user_id'
  belongs_to :friendships_invitee, class_name:'User', foreign_key:'friend_id'



end
