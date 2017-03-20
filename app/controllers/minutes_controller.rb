class MinutesController < ApplicationController
  def index
    authorize! :view_minutes, current_user
    
    @minutes_years = GoogleMinutesYear.all
    
  end
end
