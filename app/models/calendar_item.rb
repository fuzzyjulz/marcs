class CalendarItem
  attr_accessor :start_date, :description, :type
  
  def initialize(start_date, description)
    @start_date = start_date
    @description = description
  end
end
