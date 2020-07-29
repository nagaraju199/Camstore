class User < ApplicationRecord

  #has_secure_password
  # before_create :generate_token
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :carts
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  protected

  def generate_token
    self.token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless User.exists?(token: random_token)
    end
  end

  # def generate_jwt
  #   JWT.encode({ id: id,
  #               exp: 8.hours.from_now.to_i },
  #              Rails.application.secrets.secret_key_base)
  # end
end
