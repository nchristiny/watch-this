class ApplicationController < ActionController::Base
  include SessionsHelper
  respond_to :json

  protect_from_forgery with: :null_session

  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found
  def not_found
    respond_with '{"error": "Not Found"}', status: :not_found
  end

end
