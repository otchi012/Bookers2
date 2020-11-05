class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200, message: 'is too long (maximum is %{count} characters)' }
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search, keyword)
    if search == "forward_match"
      @books = Book.where("title LIKE?","#{keyword}%")
    elsif search == "backward_match"
      @books = Book.where("title LIKE?","%#{keyword}")
    elsif search == "perfect_match"
      @books = Book.where(title:keyword)
    elsif search == "partial_match"
      @books = Book.where("title LIKE?","%#{keyword}%")
    else
      @books = Book.all
    end
  end
end
