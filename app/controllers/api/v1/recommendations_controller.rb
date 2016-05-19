class Api::V1::RecommendationsController < ApplicationController
  before_filter :load_recommendation_entry, only: [:show, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def new
  end

  def index
    @recommendations = Recommendation.all
    render json: @recommendations
  end

  def show
    render json: @recommendation
  end

  def create
    recommendation = Recommendation.new(recommendation_params)
    if recommendation.save
      # Run calculation
      recommendation.calculate!
      Film.zero_score!
      render json: recommendation, status: 201, location: [:api, recommendation]
    else
      render json: { errors: recommendation.errors }, status: 422
    end

  end

  def destroy
    @recommendation.destroy
    head 204
  end

  protected

    def load_recommendation_entry
      @recommendation = Recommendation.find(params[:id]) if params[:id].present?
    end

    def recommendation_params
      params.require(:recommendation).permit(:winning_title, :winning_id, :genres_pref, :rating_pref, :director_pref, :keywords_pref, :stars_pref, :decade_pref => [])
    end
end
