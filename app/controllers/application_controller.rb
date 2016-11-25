class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :marcs_image_tag, :extract_links
  
  def marcs_image_tag(*p)
    ActionController::Base.helpers.image_tag(*p).sub(/s3\.amazonaws\.com\/marcsprod/,"marcsprod.s3-ap-southeast-2.amazonaws.com").html_safe
  end
  
  def extract_links(string)
    string.gsub(/(https?:[\/\.\w\d\-?=&]+)/,"<a href='\\1'>\\1</a>").html_safe
  end
  
    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys:[:fai, :password, :password_confirmation, :remember_me] )
      devise_parameter_sanitizer.permit(:sign_in, keys:[:fai, :password, :remember_me])
      devise_parameter_sanitizer.permit(:account_update, keys:[:fai, :password, :password_confirmation, :current_password])
    end
end
