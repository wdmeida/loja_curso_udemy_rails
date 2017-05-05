class Ad < ApplicationRecord
  belongs_to :category
  belongs_to :member

  scope :last_six_ads, -> { limit(6).order(created_at: :desc) }


  # paperclip
  has_attached_file :picture, styles: { medium: "320x150#", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  
  # gem money-rails (disponibility price)
  monetize :price_cents
end
