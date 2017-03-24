class MemberPage
  include Capybara::DSL
  
  def open
    visit("/")
    find(".membersSectionMenu").click
    
    self
  end
  
  def login(member)
    login_with_details(member.fai, member.last_name)
  end
  
  def login_with_details(username, password)
    open
    assert_text("You need to sign in or sign up before continuing.")
    fill_in("user_fai", with: username)
    fill_in("user_password", with: password)
    click_on "Log in"
    visit("/")
    self
  end
  
  def logged_in?
    has_text? "Sign Out"
  end
end
