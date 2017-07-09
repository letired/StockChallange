class Stock < ApplicationRecord

  #Soft Delete Gem
  acts_as_paranoid

  belongs_to :bearer
  belongs_to :market_price

  validates :name, presence: true

  validates_each :name do |record, attr, value|
    record.errors.add(attr, 'is invalid') if value == "invalid"
  end
end
