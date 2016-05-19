require 'rails_helper'

RSpec.describe Recommendation, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:recommendation)).to be_valid
  end

  it "has a valid genres_pref" do
    is_expected.to validate_presence_of(:genres_pref)
  end

  it "has a valid director_pref" do
    is_expected.to validate_presence_of(:director_pref)
  end

  it "has a valid rating_pref" do
    is_expected.to validate_presence_of(:rating_pref)
  end

  it "has a valid decade_pref" do
    is_expected.to validate_presence_of(:decade_pref)
  end

  it "has a valid keywords_pref" do
    is_expected.to validate_presence_of(:keywords_pref)
  end
  it "has a valid stars_pref" do
    is_expected.to validate_presence_of(:stars_pref)
  end

end
