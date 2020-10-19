class Book < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200, message: 'is too long (maximum is %{count} characters)' }
  belongs_to :user
end
