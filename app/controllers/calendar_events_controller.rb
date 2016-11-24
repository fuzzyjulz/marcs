class CalendarEventsController < ApplicationController
  helper_method :get_time_format
  @@latest_main_calendar_update = nil
  @@latest_comittee_calendar_update = nil
  @@calendar_time_format = "%d %b at %l:%M%p"
  
  def index
    if (@@latest_main_calendar_update.nil? or @@latest_main_calendar_update < Time.now - 1.days)
      @@main_events = get_calendar(ENV["CLUB_CALENDAR"])
      @@latest_main_calendar_update = Time.now
    end
    
    @events = @@main_events
    
    if can? :view_committee_calendar, current_user
      if (@@latest_comittee_calendar_update.nil? or @@latest_comittee_calendar_update < Time.now - 1.days)
        @@committee_events = get_calendar(ENV["COMMITTEE_CALENDAR"])
        @@latest_comittee_calendar_update = Time.now
      end
  
      @events = @@main_events + @@committee_events
      @events.sort! { |a,b| a.dtstart <=> b.dtstart}
    end

    @events_by_month = Hash.new(0)
    @events.each do |event|
      this_month_group = event.dtstart.strftime("%B")
      @events_by_month[this_month_group] = [] unless @events_by_month[this_month_group].nil?
        
      @events_by_month[this_month_group] << event
    end

    render layout: nil
  end
  
  def get_time_format
    @@calendar_time_format
  end
  
  def get_calendar(address)
    events = nil
    open(address) do |cal|
      main_calendar = Icalendar::Calendar.parse(cal)
      main_calendar.each do |calendar|
        events = get_relevant_events(calendar.events)
      end
    end
    events
  end
  
  def get_relevant_events(event_list)
    event_list.reject! { |e| !e.dtstart.between?(DateTime::now.prev_month(2), DateTime::now.next_month(2)) }
    event_list.sort! { |a,b| a.dtstart <=> b.dtstart}
    event_list
  end
end
