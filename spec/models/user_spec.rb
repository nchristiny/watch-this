require 'rails_helper'
describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:email) }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }

  it { should respond_to :password, :password= }
  it { should respond_to(:password_confirmation) }
  it { should respond_to :password_digest, :password_digest= }

  it { should be_valid }
end
