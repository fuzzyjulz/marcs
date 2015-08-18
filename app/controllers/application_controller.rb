class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def facebook_client_id
    ENV["FB_CLIENT_ID"]
  end
  def facebook_secret
    ENV["FB_SECRET"]
  end
end
