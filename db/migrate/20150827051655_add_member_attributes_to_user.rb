class AddMemberAttributesToUser < ActiveRecord::Migration
  def change
    add_column(:users, :financial, :string)
    add_column(:users, :first_name, :string)
    add_column(:users, :last_name, :string)
    add_column(:users, :street, :string)
    add_column(:users, :city, :string)
    add_column(:users, :postcode, :string)
    add_column(:users, :home_phone, :string)
    add_column(:users, :mobile_phone, :string)
    add_column(:users, :maaa_instructor, :boolean)
    add_column(:users, :club_instructor_type, :string)
    
    create_table(:user_wings) do |t|
      t.integer :user_id,  null: false
      t.string :wing_type,  null: false
      t.string :rank,  null: false
    end
    add_index :user_wings, [:user_id, :wing_type], :unique => true
  end
end
