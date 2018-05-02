class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # 發表文章
  has_many :posts, dependent: :destroy

  ROLE = { 
       'normal': 'normal',
       'admin': 'admin'
      } 

  def admin?
    self.role == "admin"
  end
end
