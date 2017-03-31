#Allows for capturing and creating events in google analytics. used in conjunction with the GA Helper 

class GaEvent
  EVENT_SESSION_PARAM = :ga_events
  
  EVENT_CATEGORY = {
          login_process: [:sign_in, :register, :confirmed],
          general: [:invalid_url]}
  
  attr_accessor :category, :action, :label, :value, :user_email, :options

  def initialize(params)
    @category = params[:category]
    @action = params[:action]
    @label = StringHelper.safe_chars(params[:label])
    @value = StringHelper.safe_chars(params[:value])
    @user_email = params[:user].email if params[:user].present?
  end
  
  def validate_event()
    if EVENT_CATEGORY[@category].nil? or !EVENT_CATEGORY[@category].include?(@action)
      raise "The specified category and action wasn't allowed."
    end
    if !@value.nil? and !(@value.is_a? Integer or @value.is_a? Float)
      raise "Value must be a number."
    end
  end
  
  def add_event(session)
    events = GaEvent.get_events(session)
    validate_event
    events << self
    self
  end
  
  def self.get_events(session)
    events = session[EVENT_SESSION_PARAM]
    events ||= session[EVENT_SESSION_PARAM] = []
  end
  
  def self.clear(session)
    session[EVENT_SESSION_PARAM] = nil
  end
  
  def to_s
    "Event:#{@category}:#{@action}:#{@label}:#{@value}:#{@user_email} #{options}"
  end
  
  private 
  def set_option(key, value)
    if !@options
      @options = {}
    end
    @options[key] = value
  end
end