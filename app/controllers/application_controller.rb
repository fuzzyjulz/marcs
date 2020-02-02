class ApplicationController < ActionController::Base
  include Analytics
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :marcs_image_tag, :extract_links, :show_member_submenu, :show_committee_submenu, :renderAsAjax,
    :agm_time?, :financial_half_year?, :financial_year, :renewal_financial_half_year?, :renewal_financial_year, 
    :within_half_year_warning?, :within_full_year_warning?, :safe_chars
  
  def marcs_image_tag(*p)
    ActionController::Base.helpers.image_tag(*p).sub(/s3\.amazonaws\.com\/marcsprod/,"marcsprod.s3-ap-southeast-2.amazonaws.com").html_safe
  end
  
  def extract_links(string)
    string.gsub(/(https?:[\/\.\w\d\-?=&]+)/,"<a href='\\1'>\\1</a>").html_safe
  end
  
  def show_member_submenu
    (self.is_a? UsersController or self.is_a? MinutesController or self.is_a? MembershipYearsController  or self.is_a? MembershipBatchesController or action_name == "club_rules") \
    and can? :view_member_area, current_user
  end
  
  def show_committee_submenu
    show_member_submenu \
    and can? :view_commitee_area, current_user
  end
  
  def agm_time?
    (6..7).include? Date.today.month
  end

  def financial_half_year?
    (1..5).include? Date.today.month
  end

  def renewal_financial_half_year?
    (11..12).include? Date.today.month or (1..5).include? Date.today.month
  end

  def self.financial_year
    (1..6).include?(Date.today.month) ? Date.today.year-1 : Date.today.year
  end

  def renewal_financial_year
    (1..5).include?(Date.today.month) ? Date.today.year-1 : Date.today.year
  end

  def financial_year
    ApplicationController.financial_year
  end

  def within_half_year_warning?
    Date.today.month == 11
  end
  
  def within_full_year_warning?
    Date.today.month == 5
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to home_user_path, :alert => exception.message
  end
  
  def renderAsAjax(path_url,params = {})
    if Rails.env.test?
      path = Rails.application.routes.recognize_path path_url
      c = "#{path[:controller]}_controller".camelize.constantize.new
      c.params = params
      resp = ActionDispatch::Response.new
      c.dispatch(path[:action], request, resp)
      resp.body.html_safe
    else
      "<div class='jqueryLoad' href='#{path_url}'></div>".html_safe
    end
  end

  def safe_chars(value)
    value.present? ? value.to_s.gsub(/[^0-9a-zA-z\-_: ,]/,'').html_safe : nil
  end
  
  ActionController::Renderers.add :csv do |obj, options|
    filename = options[:filename] || 'data'
    str = obj.respond_to?(:to_csv) ? obj.to_csv : obj.to_s
    send_data str, type: Mime[:csv],
      disposition: "attachment; filename=#{filename}.csv"
  end
  
  protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys:[:fai, :password, :password_confirmation, :remember_me] )
      devise_parameter_sanitizer.permit(:sign_in, keys:[:fai, :password, :remember_me])
      devise_parameter_sanitizer.permit(:account_update, keys:[:fai, :password, :password_confirmation, :current_password])
    end
end
