class HomePage 
  include Capybara::DSL
  
  def open()
    visit("/")
  end
end
