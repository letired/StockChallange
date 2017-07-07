class Stock < ApplicationRecord
  belongs_to :bearer
  belongs_to :market_price

  validates :name, presence: true
end
