class ConfirmRenewalsPage
  include Capybara::DSL
  
  def open
    MemberPage.new.open
    find(".renewals").click
    self
  end

  def visit_page
    visit("/membership")
    self
  end

  def payment_date_field(member)
    member_id = User.find_by(fai: member.fai).id
    find_all(".member#{member_id} .membership_year_payment_date")
  end
  
  def paid_button(member)
    member_id = User.find_by(fai: member.fai).id
    find_all(".member#{member_id} .paidBtn")
  end

  def set_paid(member, payment_date)
    payment_date_field(member).first.fill_in(with: payment_date);
    paid_button(member).first.click
  end
end
