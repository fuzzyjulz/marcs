class GoogleMinutes
  attr_reader :type, :filename, :view_url
  
  def initialize(file)
    @filename = file.title.gsub(/\..*$/,"").tr('_',' ').capitalize
    @view_url = file.web_view_link
    @type = get_type_for_filename(@filename)
  end
  
  def get_type_for_filename(filename)
    compare_filename = filename.downcase
    
    if compare_filename.include? "template"
      nil
    elsif compare_filename.include? "club"
      :club_meeting
    elsif compare_filename.include? "committee"
      :committee_meeting
    elsif compare_filename.include? "agm"
      :agm_meeting
    else
      nil
    end
  end
end
