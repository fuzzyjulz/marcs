Before('@Member') do
  @member = Members::STANDARD_MEMBER
  assert MemberPage.new.login(@member).logged_in?, "Not logged in"
end

Before('@Committee') do
  @member = Members::COMMITTEE_MEMBER
  assert MemberPage.new.login(@member).logged_in?, "Not logged in"
end

Before('@NonFinancialMember') do
  @member = Members::NON_FINANCIAL_MEMBER
  assert MemberPage.new.login(@member).logged_in?, "Not logged in"
end
