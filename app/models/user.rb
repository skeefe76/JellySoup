class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_create :create_activation_digest

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

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # # Returns true if the given token matches the digest.
  # def authenticated?(remember_token)
  #   BCrypt::Password.new(remember_digest).is_password?(remember_token)
  # end
  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  private
  # Creates and assigns the activation token and digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
