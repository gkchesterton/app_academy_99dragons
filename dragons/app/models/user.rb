class User < ActiveRecord::Base
  attr_accessible :name, :session_token, :password
  before_validation :reset_session_token, on: :create
  validates :name, :password_digest, :session_token, presence: true

  has_many :dragons
  has_many :sessions, class_name: "UserSession"

  def reset_session_token(environment)
    # self.session_token = SecureRandom::urlsafe_base64(16)
    UserSession.create!(user_id: self.id,
                        session_token: SecureRandom::urlsafe_base64(16),
                        environment: environment,
                        geo: "asdf")
  end

  def password=(pt)
    self.password_digest = BCrypt::Password.create(pt)
  end

  def is_password?(pt)
     BCrypt::Password.new(self.password_digest).is_password?(pt)
  end

  def self.find_by_credentials(user_name, pt)
    user = User.find_by_name(user_name)
    return nil unless user
    user.is_password?(pt) ? user : nil
  end

end
