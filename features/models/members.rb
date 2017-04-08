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
  NON_FINANCIAL_MEMBER = Members.new(5678,'NonFinancial','Member', 'nonf_member@marcs.org.au', '10 Not Fin street', 'Memberberg', '5678')

  UPDATED_MEMBER = Members.new(1,'Updated','Member', 'updated_email@marcs.org.au', '30 Updated Lane', 'Memberberg', '0000')
end
