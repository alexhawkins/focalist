class ApplicationController < ActionController::Base
  include Pundit
  # To handle when Pundit throws an exception error, making the 
  # restriction as user friendly as possible,
  # we add this rescue_from block to the application_controller.rb:
  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
