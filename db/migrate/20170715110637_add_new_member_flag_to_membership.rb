class AddNewMemberFlagToMembership < ActiveRecord::Migration
  def change
    add_column(:membership_years, :new_member, :boolean, default: false, null: false)
    add_column(:membership_fees, :new_member, :boolean, default: false, null: false)
    
    remove_index :membership_fees, column: [:year,:half_year, :membership_type]
    add_index :membership_fees, [:year,:half_year, :membership_type, :new_member], unique: true, name: 'membership_fees_unique_key'
  end
end
