class AddBatchNumberToMembershipYears < ActiveRecord::Migration
  def change
    add_column(:membership_years, :batch, :integer)
  end
end
