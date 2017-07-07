class MarketPrice < ApplicationRecord
  has_many :stocks
  validates :currency, :value_cents, presence: true
  validates :currency, uniqueness: { scope: :value_cents, message: "only one currency value pair needed"}
end
