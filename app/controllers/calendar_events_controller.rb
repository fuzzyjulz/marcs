class CalendarEventsController < ApplicationController
  helper_method :get_time_format
  @@latest_main_calendar_update = nil
  @@latest_comittee_calendar_update = nil
  @@calendar_time_format = "%d %b at %l:%M%p"
  
  def index
    @@latest_main_calendar_update = nil
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
      @events.sort! { |a,b| a.start_date <=> b.start_date}
    end

    @events_by_month = Hash.new(0)
    @events.each do |event|
      this_month_group = event.start_date.strftime("%B")
      
      @events_by_month[this_month_group] = [] if (@events_by_month[this_month_group] == 0) 
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
        events = get_relevant_events(calendar.events, 2)
      end
    end
    events
  end
  
  def get_relevant_events(event_list, months)
    final_events = []
    
    event_list.each do |event|
      if event.rrule.present?
        final_events << event \
        .occurrences_between(DateTime::now.prev_month(months), DateTime::now.next_month(months)) \
        .map!{ |event_occ| CalendarItem.new(event_occ.start_time, event.summary)}
      end
    end
    
    final_events << event_list \
      .delete_if { |e| !e.dtstart.between?(DateTime::now.prev_month(months), DateTime::now.next_month(months)) } \
      .map!{ |event| CalendarItem.new(event.dtstart.value, event.summary)}

    final_events.flatten!
    final_events.compact!
    final_events.sort! { |a,b| a.start_date <=> b.start_date}
    
    final_events
  end
end
