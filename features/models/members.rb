class Members
  attr_accessor :fai, :first_name, :last_name, :email, :street, :suburb, :postcode
  
  def initialize(fai, firstname, surname, email, street, suburb, postcode)
    @fai = fai
    @first_name = firstname
    @last_name = surname
    @email = email
    @street = street
    @suburb = suburb
    @postcode = postcode
  end

  STANDARD_MEMBER = Members.new(1234,'Test','Member', 'test_member@marcs.org.au', '10 test street', 'Memberberg', '5678')
  COMMITTEE_MEMBER = Members.new(4321,'Committee','Representitive', 'test_committee@marcs.org.au', '20 test street', 'Committeeville','8765')
end
