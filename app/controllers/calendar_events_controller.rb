class CalendarEventsController < ApplicationController
  helper_method :get_time_format
  @@calendar_time_format = "%d %b at %l:%M%p"
  
  def index
    @events = get_club_events

    if can? :view_committee_calendar, current_user
      @events = @events + get_committee_events
    end

    @events.sort! { |a,b| a.start_date <=> b.start_date}

    @events_by_month = get_events_by_month(@events)

    render layout: nil
  end
  
  def get_events_by_month(events)
    events_by_month = Hash.new(0)
    events.each do |event|
      this_month_group = event.start_date.strftime("%B")
      
      events_by_month[this_month_group] = [] if (events_by_month[this_month_group] == 0) 
      events_by_month[this_month_group] << event
    end
    events_by_month
  end
  
  def get_club_events()
    Rails.cache.fetch("club_events", expires_in: 1.days, force: Rails.env.test?) do
      get_calendar(ApplicationHelper::CLUB_CALENDAR_ICS_URL, :club)
    end
  end
  
  def get_committee_events()
    Rails.cache.fetch("committee_events", expires_in: 1.days, force: Rails.env.test?) do
      get_calendar(ApplicationHelper::COMMITTEE_CALENDAR_ICS_URL, :committee)
    end
  end
  
  def get_time_format
    @@calendar_time_format
  end
  
  def get_calendar(address, type)
    events = nil
    open(address) do |cal|
      main_calendar = Icalendar::Calendar.parse(cal)
      main_calendar.each do |calendar|
        events = get_relevant_events(calendar.events, 2)
      end
    end
    events.each {|event| event.type = type}
    events
  end
  
  def get_relevant_events(event_list, months)
    final_events = []
    
    event_list.each do |event|
      if event.rrule.present?
        final_events << event \
        .occurrences_between(DateTime.current, DateTime.current.next_month(months)) \
        .map!{ |event_occ| CalendarItem.new(event_occ.start_time, event.summary)}
      end
    end
    
    final_events << event_list \
      .delete_if { |e| !e.dtstart.between?(DateTime.current, DateTime.current.next_month(months)) } \
      .map!{ |event| CalendarItem.new(event.dtstart.value, event.summary)}

    final_events.flatten!
    final_events.compact!
    final_events.sort! { |a,b| a.start_date <=> b.start_date}
    
    final_events
  end
end
