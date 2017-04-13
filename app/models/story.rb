class Story < ApplicationRecord
  belongs_to :user

  has_many  :reviews, dependent: :destroy

  validates :title, :manuscript, presence: true
  validates :manuscript, length: { minimum: 100 }

  cattr_accessor :current_user

  scope :mystories, -> { where("user_id == ?", Story.current_user).order(updated_at: :desc) }


  def to_param
    "#{id}-#{title.parameterize}"
  end
end
