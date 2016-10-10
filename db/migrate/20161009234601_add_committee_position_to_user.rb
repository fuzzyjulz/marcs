class AddCommitteePositionToUser < ActiveRecord::Migration
  def change
    add_column(:users, :committee_position, :string)
  end
end
