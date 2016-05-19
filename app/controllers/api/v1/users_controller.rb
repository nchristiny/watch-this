class Api::V1::UsersController < ApplicationController
  before_filter :load_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      user.generate_auth_token
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update

    if @user.update(user_params)
      render json: @user, status: 200, location: [:api, @user]
    else
      render json: { errors: @user.errors }, status: 422
    end
  end

  def destroy

    @user.destroy
    head 204
  end

  private

    def load_user
      @user = User.find(params[:id])
      head 404 and return unless @user.present?
    end

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

end
