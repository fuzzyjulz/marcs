class MemberRenewalPage
  include Capybara::DSL
  
  def open
    MemberPage.new.open
    find(".renewMembership").click
    self
  end
  
  def agree_to_rules()
    check('membership_year_club_rules_accepted')

    self
  end
  
  def accept_membership_details
    click_on("Next")
    
    self
  end
end
