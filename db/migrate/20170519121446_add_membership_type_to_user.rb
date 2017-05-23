class AddMembershipTypeToUser < ActiveRecord::Migration
  def change
    add_column(:users, :membership_type, :string)
    add_column(:users, :affiliated_club, :string)
    add_column(:users, :pensioner_number, :string)
    add_column(:users, :student_number, :string)
  end
end
