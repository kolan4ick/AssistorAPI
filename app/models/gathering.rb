class Gathering < ApplicationRecord
  has_many_attached :photos

  has_many_attached :finished_photos

  belongs_to :creator, class_name: 'Volunteer'

  belongs_to :gathering_category

  has_many :gathering_views

  has_many :favourite_gatherings

  def is_monobank_link?
    link.include? 'send.monobank.ua/jar/'
  end

  validates :title, presence: true
  validates :description, presence: true
  validates :sum, presence: true
  validates :start, presence: true
  validates :end, presence: true
  validates :link, presence: true, format: { with: URI.regexp }
end
