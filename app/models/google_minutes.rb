class GoogleMinutes
  attr_reader :type, :filename, :view_url
  
  def initialize(file)
    @filename = file.title.gsub(/\..*$/,"").gsub(/_/," ").capitalize
    @view_url = file.web_view_link
    if @filename.downcase.include? "club" and !@filename.downcase.include? "template"
      @type = :club_meeting
    elsif @filename.downcase.include? "committee" and !@filename.downcase.include? "template"
      @type = :committee_meeting
    elsif @filename.downcase.include? "agm" and !@filename.downcase.include? "template"
      @type = :agm_meeting
    end
  end
end
