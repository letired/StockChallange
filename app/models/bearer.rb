class Bearer < ApplicationRecord
  has_many :stocks

  validates :name, presence: true
  validates :name, uniqueness: true

  validates_each :name do |record, attr, value|
    record.errors.add(attr, 'cannot be called invalid') if value == "invalid"
  end
end
