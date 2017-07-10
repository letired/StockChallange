class Stock < ApplicationRecord

  #Soft Delete Gem
  acts_as_paranoid

  belongs_to :bearer
  belongs_to :market_price

  validates :name, presence: true

  validates_each :name, :bearer_name do |record, attr, value|
    record.errors.add(attr, 'is invalid') if value == "invalid"
  end

  #Virtual Attributes update parent model

  attr_accessor :bearer_name, :value_cents, :currency

  before_validation :set_bearer, :set_market_price

  private

  def set_bearer
    if self.bearer_name
      self.bearer = Bearer.where(name: self.bearer_name).first_or_create
    end
  end

  def set_market_price
    if self.value_cents && self.currency
      self.market_price = MarketPrice.where(value_cents: self.value_cents, currency: self.currency).first_or_create
    end
  end
end
