class Category < ApplicationRecord
	validates_presence_of :description

	scope :order_by_description, -> { order(:description) }
end
