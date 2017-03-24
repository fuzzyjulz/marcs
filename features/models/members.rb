class Members
  attr_accessor :fai, :firstname, :surname
  
  def initialize(fai, firstname, surname)
    @fai = fai
    @firstname = firstname
    @surname = surname
  end

  STANDARD_MEMBER = Members.new(1234,'Test','Member')
  COMMITTEE_MEMBER = Members.new(4321,'Committee','Representitive')
end
