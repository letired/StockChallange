require 'rails_helper'

RSpec.describe MarketPrice, type: :model do
  subject { FactoryGirl.build(:market_price) }

  context "Validations" do
    it "has a valid factory" do
      expect(subject).to be_valid
    end

    it "is not valid without a currency" do
      subject.currency = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a cent value" do
      subject.value_cents = nil
      expect(subject).to_not be_valid
    end

    it "is unique by currency and cent value pair" do
      FactoryGirl.create(:market_price)
      expect(FactoryGirl.build(:market_price_2)).to be_valid
      expect(subject).to_not be_valid
    end
  end

  context "Associations" do
    it { should have_many(:stocks) }
  end
end
