class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { maximum: 50, message: 'is too long (maximum is %{count} characters)' }
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :following_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :following_relationships, source: :followed

  has_many :follower_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower

  attachment :profile_image

  # ユーザーをフォローする
def follow!(user_id)
  following_relationships.create!(followed_id: user_id)
end

# ユーザーのフォローを外す
def unfollow!(user_id)
  following_relationships.find_by(followed_id: user_id).destroy
end

# フォローしていればtrueを返す
def following?(user)
  following_relationships.include?(user)
end
end
