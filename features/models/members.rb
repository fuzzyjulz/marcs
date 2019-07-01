class Members
  attr_accessor :fai, :first_name, :last_name, :membership_type, :life_member, :affiliate, :email, :street, :suburb, :postcode
  
  def initialize(fai, firstname, surname, membership_type, life_member, affiliate, email, street, suburb, postcode)
    @fai = fai
    @first_name = firstname
    @last_name = surname
    @membership_type = membership_type
    @life_member = life_member
    @affiliate = affiliate
    @email = email
    @street = street
    @suburb = suburb
    @postcode = postcode
  end
  
  def name
    "#{first_name} #{last_name}"
  end

  STANDARD_MEMBER = Members.new(1234,'Test','Member', :senior, false, false, 'test_member@marcs.org.au', '10 test street', 'Memberberg', '5678')
  COMMITTEE_MEMBER = Members.new(4321,'Committee','Representitive', :senior, false, false, 'test_committee@marcs.org.au', '20 test street', 'Committeeville','8765')
  NON_FINANCIAL_MEMBER = Members.new(5678,'NonFinancial','Member', :senior, false, false, 'nonf_member@marcs.org.au', '10 Not Fin street', 'Memberberg', '5678')
  AFFILIATE_MEMBER = Members.new(1235,'Affiliate','Member', :senior, false, true, 'aff_member@marcs.org.au', '10 test street', 'Memberberg', '5678')
  LIFE_MEMBER = Members.new(1236,'Life','Member', :senior, true, false, 'life_member@marcs.org.au', '10 test street', 'Memberberg', '5678')
  STUDENT_MEMBER = Members.new(1237,'Student','Member', :student, false, true, 'student_member@marcs.org.au', '10 test street', 'Memberberg', '5678')
  PENSIONER_MEMBER = Members.new(1238,'Pensioner','Member', :pensioner, false, true, 'pensioner_member@marcs.org.au', '10 test street', 'Memberberg', '5678')
  JUNIOR_MEMBER = Members.new(1239,'Junior','Member', :junior, false, true, 'junior_member@marcs.org.au', '10 test street', 'Memberberg', '5678')
  SPECTATOR_MEMBER = Members.new(1240,'Spector','Member', :spectator, false, true, 'spectator_member@marcs.org.au', '10 test street', 'Memberberg', '5678')

  UPDATED_MEMBER = Members.new(1,'Updated','Member', :senior, false, false, 'updated_email@marcs.org.au', '30 Updated Lane', 'Memberberg', '0000')
end
