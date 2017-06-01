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

Before('@AffiliateMember') do
  @member = Members::AFFILIATE_MEMBER
  assert MemberPage.new.login(@member).logged_in?, "Not logged in"
end

Before('@LifeMember') do
  @member = Members::LIFE_MEMBER
  assert MemberPage.new.login(@member).logged_in?, "Not logged in"
end

Before('@StudentMember') do
  @member = Members::STUDENT_MEMBER
  assert MemberPage.new.login(@member).logged_in?, "Not logged in"
end

Before('@PensionerMember') do
  @member = Members::PENSIONER_MEMBER
  assert MemberPage.new.login(@member).logged_in?, "Not logged in"
end

Before('@JuniorMember') do
  @member = Members::JUNIOR_MEMBER
  assert MemberPage.new.login(@member).logged_in?, "Not logged in"
end
