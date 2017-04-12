class Story < ApplicationRecord
  has_many  :reviews, dependent: :destroy
  validates :title, :manuscript, presence: true
  validates :manuscript, length: { minimum: 100 }
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
