require 'rails_helper'

RSpec.describe Film, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:film)).to be_valid
  end

  it "has a valid score" do
    is_expected.to validate_presence_of(:score)
  end

  it "has a valid title" do
    is_expected.to validate_presence_of(:title)
  end

  it "has a valid rating" do
    is_expected.to validate_presence_of(:rating)
  end

  it "has a valid summary" do
    is_expected.to validate_presence_of(:summary)
  end

  it "has a valid poster_url" do
    is_expected.to validate_presence_of(:poster_url)
  end

   it "has a valid url" do
    is_expected.to validate_presence_of(:url)
  end

  it "has a valid director" do
    is_expected.to validate_presence_of(:director)
  end

  it "has a valid year" do
    is_expected.to validate_presence_of(:year)
  end

end
