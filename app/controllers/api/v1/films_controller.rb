class Api::V1::FilmsController < ApplicationController
  before_filter :load_film_entry, only: [:show]

  def index
    @films = Film.all
    render json: @films
  end

  def show
    render json: @film
  end

  protected

    def load_film_entry
      @film = Film.find(params[:id]) if params[:id].present?
    end
end
