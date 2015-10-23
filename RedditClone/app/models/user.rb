class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6 }
  validates :username, :session_token, uniqueness: true

  before_validation :ensure_session_token

  attr_reader :password

  def self.generate_session_token
    SecureRandom.base64(16)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    session[:session_token] = nil
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
