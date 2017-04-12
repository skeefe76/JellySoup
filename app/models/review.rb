class Review < ApplicationRecord
  belongs_to :story
  belongs_to :user
  validates :comment, length: { minimum: 10 }
end
