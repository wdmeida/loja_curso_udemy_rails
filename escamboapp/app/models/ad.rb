class Ad < ApplicationRecord
  belongs_to :category
  belongs_to :member

  # gem money-rails (disponibility price)
  monetize :price_cents
end
