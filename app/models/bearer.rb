class Bearer < ApplicationRecord
  has_many :stocks

  validates :name, presence: true
  validates :name, uniqueness: true

  validates_each :name do |record, attr, value|
    record.errors.add(attr, 'is invalid') if value == "invalid"
  end
end
