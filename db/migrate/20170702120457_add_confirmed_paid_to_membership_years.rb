class AddConfirmedPaidToMembershipYears < ActiveRecord::Migration
  def change
    add_column(:membership_years, :confirmed_paid, :boolean)
  end
end
