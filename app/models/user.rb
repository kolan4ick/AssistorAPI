class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :api, authentication_keys: [:login]

  has_many :gathering_views, as: :viewer
  has_many :viewed_gatherings, through: :gathering_views, source: :gathering

  has_many :favourite_gatherings, as: :favouritable
  has_many :favourites, through: :favourite_gatherings, source: :gathering

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # validations
  validates :name, presence: true
  validates :surname, presence: true
end
