require 'rails_helper'

describe Api::V1::FilmsController, type: :controller do

  describe "GET #index" do
    random_number = 2 + rand(10)
    before(:each) do
      random_number.times do
        FactoryGirl.create(:film)
      end
      get :index
    end

    context 'all films' do
      it 'returns all the films' do
        films = Film.all
        expect(films.count).to be random_number
      end

      it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end

      describe '#index @films' do
        subject { assigns(:films) }
        it "should contain all #{random_number} items" do
          expect(subject.size).to eq random_number
        end
      end
    end
  end

  describe "GET '/api/films/:id'" do
    let(:film) { FactoryGirl.create(:film, title: "Generic but unique Title") }
    before(:each) do
      get :show, id: film.id
    end

    it 'responds with the correct film in JSON format' do
      expect(json_response[:title]).to eq "Generic but unique Title"
    end

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    # it 'response with 404 if film not found' do
    #   get :show, controller: "api/films/nope.json"
    #   expect(response["error"]).to eq "not_found"
    #   expect(response).to have_http_status(404)
    # end
  end

end
