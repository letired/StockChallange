require 'rails_helper'

RSpec.describe Bearer, type: :model do
  subject { FactoryGirl.build(:bearer) }

  context "Validations" do
    it "has a valid factory" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with the name 'invalid'" do
      subject.name = "invalid"
      expect(subject).to_not be_valid
    end

    it "is unique by name" do
      FactoryGirl.create(:bearer)
      expect(subject).to_not be_valid
    end
  end

  context "Associations" do
    it { should have_many(:stocks) }
  end
end
