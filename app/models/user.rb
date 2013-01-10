class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  has_secure_password
  
  has_many :photos, dependent: :destroy
  has_many :events
  
  validates :first_name, presence: true, length: {maximum: 30}
  validates :last_name, presence: true, length: {maximum: 30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  def name
    "#{first_name} #{last_name}"
  end
  
  def profile_picture
    photos.try(:first).try(:image).try(:url, :thumb_square) || nil
  end
  
  private
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
