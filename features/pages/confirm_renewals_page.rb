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
    find_all(".member#{member_id(member)} .membership_year_payment_date")
  end
  
  def paid_button(member)
    find_all(".member#{member_id(member)} .paidBtn")
  end

  def set_paid(member, payment_date)
    payment_date_field(member).first.fill_in(with: payment_date);
    paid_button(member).first.click
  end
  
  def revert_paid_button(member)
    find_all(".member#{member_id(member)} .revertPaidBtn")
  end

  def set_revert_paid(member)
    revert_paid_button(member).first.click
  end
  
  def member_id(member)
    member_id = User.find_by(fai: member.fai).id
  end
end
