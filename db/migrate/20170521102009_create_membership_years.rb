class CreateMembershipYears < ActiveRecord::Migration
  def change

    create_table :membership_years, primary_key: [:user_id, :year] do |t|
      
      t.integer :user_id, null: false
      t.integer :year, null: false
      t.boolean :half_year, null: false
      t.string  :membership_type, null: false
      t.string  :pensioner_number
      t.string  :student_number
      t.boolean :life_member, null: false
      t.boolean :affiliate, null: false
      t.string  :affiliated_club
      t.boolean :club_rules_accepted, null: false
      t.string  :payment_authorised_number
      t.timestamp  :payment_date
      t.timestamps
    end
    add_foreign_key :membership_years, :users

    create_table :membership_fees, primary_key: [:year, :half_year] do |t|
      t.integer :year, null: false
      t.boolean :half_year, null: false
      t.string  :membership_type, null: false
      t.decimal :club_membership_fee, null: false
      t.decimal :insurance_fee, null: false
    end
  end
end
