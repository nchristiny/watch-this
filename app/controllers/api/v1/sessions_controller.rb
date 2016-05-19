class Api::V1::SessionsController < ApplicationController

  def create
    handle_authentication_failure and return unless params[:session].present?
    email = params[:session][:email]
    password = params[:session][:password]
    user = User.find_by_email(email)

    if user.present? && user.authenticate(password)
      user.save
      token = user.auth_token
      render :json => { :user => user, :auth_token => token },
      :status => 201
    else
      handle_authentication_failure
    end
  end

  def destroy
    token = AuthenticationToken.find_by_token(current_authentication_token)
    if token.present?
      token.destroy
      head 204
    else
      head 404
    end
  end

  private

    def handle_authentication_failure
      head 401
    end
end
