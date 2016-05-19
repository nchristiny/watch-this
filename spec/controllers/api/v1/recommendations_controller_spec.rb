require 'rails_helper'

describe Api::V1::RecommendationsController, type: :controller do

  describe "GET '/api/recommendations/'" do
    random_number = 2 + rand(10)
    before(:each) do
      random_number.times do
        FactoryGirl.create(:recommendation)
      end
      get :index
    end
    context 'all recommendations' do
      it 'returns all the recommendations' do
        recommendations = Recommendation.all
        expect(recommendations.count).to be random_number
      end

      it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      describe '#index @recommendations' do
        subject { assigns(:recommendations) }
        it "should contain all #{random_number} items" do
          expect(subject.size).to eq random_number
        end
      end
    end
  end

  describe "GET '/api/recommendations/:id'" do
    let(:recommendation) { FactoryGirl.create(:recommendation, winning_title: "Generic but unique Title") }
    before(:each) do
      get :show, id: recommendation.id
    end

    it 'responds with the correct film in JSON format' do
      expect(json_response[:winning_title]).to eq "Generic but unique Title"
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST '/api/recommendations" do

    context "when is successfully created" do
      before(:each) do
        FactoryGirl.create(:film)
        @recommendation_attributes = FactoryGirl.attributes_for :recommendation
        post :create, { recommendation: @recommendation_attributes }, format: :json
      end

      it "renders the json representation for the recommendation record just created" do
        recommendation_response = JSON.parse(response.body, symbolize_names: true)
        expect(recommendation_response[:decade_pref]) === @recommendation_attributes[:decade_pref]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        @invalid_recommendation_attributes = { password: "12345678",
         password_confirmation: "12345678" }
         post :create, { recommendation: @invalid_recommendation_attributes }, format: :json
       end

       it "renders an errors json" do
        recommendation_response = JSON.parse(response.body, symbolize_names: true)
        expect(recommendation_response).to have_key(:errors)
      end

      it "renders the json errors on why the recommendation could not be created" do
        recommendation_response = JSON.parse(response.body, symbolize_names: true)
        expect(recommendation_response[:errors][:genres_pref]).to include "can't be blank"
      end
      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @recommendation = FactoryGirl.create :recommendation
      delete :destroy, { id: @recommendation.id }, format: :json
    end
    it { should respond_with 204 }
  end
end
