class Volunteer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :token_authenticatable, authentication_keys: [:login]

  has_many :created_gatherings, class_name: 'Gathering', foreign_key: 'creator_id'

  has_many :gathering_views, as: :viewer
  has_many :viewed_gatherings, through: :gathering_views, source: :gathering

  has_many :favourite_gatherings, as: :favouritable
  has_many :favourites, through: :favourite_gatherings, source: :gathering

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

  # Update resource without password but with :password and :password_confirmation, because we validate resource by token
  def update_without_password(params)
    params.delete(:current_password)
    params.delete(:email)
    params.delete(:username)

    update(params)
  end

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :surname, presence: true
  validates :phone, presence: true, format: { with: /\A\+?3?8?(0[5-9][0-9]\d{7})\z/ }
  validates :description, presence: true
end
