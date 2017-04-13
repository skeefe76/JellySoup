class User < ApplicationRecord

  to_param :username

  has_many :reviews, dependent: :destroy
  has_many :stories, dependent: :destroy

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    user && user.authenticate(password)
  end

  has_secure_password
  validates :password, length: { minimum: 6, allow_blank: true }
  validates :name, presence: true
  validates :email, presence: true,
                  format: /\A\S+@\S+\z/,
                  uniqueness: { case_sensitive: false }
  validates :username, presence: true,
                     format: /\A[A-Z0-9]+\z/i,
                     uniqueness: { case_sensitive: false }
end
