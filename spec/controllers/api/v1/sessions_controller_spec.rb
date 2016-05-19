require 'rails_helper'

describe Api::V1::SessionsController, type: :controller do

  describe "POST '/api/sessions'" do
    let(:user) { FactoryGirl.create :user }
    before do

      post :create
    end

    context 'without session parameters' do
      let(:auth_token) { nil }
      it { should respond_with 401 }
    end

    context 'with invalid token' do
      let(:user) {
        {
          email: user.email,
          password: 'foofoo',
          token: "invalid_token"
        }
      }
      it { should respond_with 401 }
    end
  end

end

