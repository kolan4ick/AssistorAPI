class Volunteer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :token_authenticatable, authentication_keys: [:login]

  has_many :created_gatherings, class_name: 'Gathering', foreign_key: 'creator_id'

  has_many :gathering_views, as: :viewer
  has_many :viewed_gatherings, through: :gathering_views, source: :gathering

  has_one_attached :avatar

  has_many_attached :documents

  before_save :ensure_authentication_token

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def renew_authentication_token!
    self.update(authentication_token: nil)
    self.ensure_authentication_token
  end

  def expired_authentication_token?
    DateTime.now > (authentication_token_created_at + token_expires_in)
  end

  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
