require 'rails_helper'

RSpec.describe Stock, type: :model do
  subject { FactoryGirl.build(:stock) }

  context "Validations" do
    it "has a valid factory" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a bearer" do
      subject.bearer = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a market price" do
      subject.market_price = nil
      expect(subject).to_not be_valid
    end
  end

  context "Associations" do
    it { should belong_to(:bearer) }
    it { should belong_to(:market_price) }
  end
end
