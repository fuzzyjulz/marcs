class MinutesController < ApplicationController
  helper_method :can_view
  
  def index
    authorize! :view_minutes, current_user
    
    @minutes_years = get_years.values.sort! {|a,b| b.title <=> a.title}
  end
  
  def show
    authorize! :view_minutes, current_user
    years = get_years
    @year = years[request[:id]]
    if @year.minutes.nil?
      load_minutes(@year)
      Rails.cache.write("minutes_years", years)
    end
    
    render layout: nil
  end
  
  def can_view(minutes)
    case minutes.type
    when :club_meeting
      can? :view_club_minutes, minutes
    when :committee_meeting
      can? :view_committee_minutes, minutes
    when :agm_meeting
      can? :view_agm_minutes, minutes
    else
      false
    end
  end
  
  private
  def get_years()
    Rails.cache.fetch("minutes_years", expires_in: 1.days) do
      minutes_years = Hash.new()
      GoogleMinutesYear.all.each {|year| minutes_years[year.id] = MinutesYear.new(year)}
      minutes_years
    end
  end
  
  def load_minutes(year)
    year.minutes = GoogleMinutesYear.url(year.view_url).minutes \
                     .keep_if{|minutes| !minutes.type.nil?} \
                     .map{|minutes| Minutes.new(minutes)} \
                     .sort! {|a,b| b.title <=> a.title}
  end
end
