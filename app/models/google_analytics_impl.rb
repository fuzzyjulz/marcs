class GoogleAnalyticsImpl

  DIMENSION_NAMES = [nil,'User Id', 'User First Name']
  DIMENSION_KEYS = [nil, :user_id, :first_name]
  OFFICE_IPS = ["127.0.0.1"] 
  
  def initialize(request, session, cookies, campaign, current_user)
    @ga_gabba = GabbaGMP::GabbaGMP.new(ApplicationHelper::GOOGLE_ANALYTICS_TRACKER, request, cookies)
    @ga_gabba.logger = Rails.logger
     
    @ga_gabba.add_options(user_agent: "OfficeUse") if OFFICE_IPS.include?(request.remote_ip)
     
    @ga_gabba.campaign = campaign
    if current_user
      set_ga_var(:user_id, current_user.id)
      set_ga_var(:first_name, current_user.first_name)
    else
      set_ga_var(:user_id, "notLoggedIn")
      set_ga_var(:first_name, "notLoggedIn")
    end
  end
  
  def write_pageview(request, session, title = nil)
    page = "#{request.fullpath}"
    @ga_gabba.page_view(request, "#{title}")
    Rails.logger.info "### Recorded pageview (title: #{title}, #{request.fullpath})"
  end
  
  def write_events(request, session)
    GaEvent.get_events(session).each do |event|
      option = {}
      if event.options.present?
        event.options.each_pair do |key, value|
          option["dimension_#{DIMENSION_KEYS.index(key)}".to_sym] = value
        end
      end
      @ga_gabba.event("#{event.category}", "#{event.action}", "#{event.label}", "#{event.value}", option)
      Rails.logger.info "### Event Sent"
    end
  end

  private
  def set_ga_var(dimension, value)
    dimension_index = DIMENSION_KEYS.index(dimension)
    @ga_gabba.set_custom_var(dimension_index, DIMENSION_NAMES[dimension_index], value)
    Rails.logger.info "  #{DIMENSION_NAMES[dimension_index]}: #{value}"
  end
end
