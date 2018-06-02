# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def create_membership_fee(year, membership_type, membership_fee, insurance_fee, new_member_fee)

  membership = MembershipFee.find_or_initialize_by(year: year, half_year: false, membership_type: membership_type, new_member: false)
  membership.club_membership_fee = membership_fee
  membership.insurance_fee = insurance_fee
  membership.save!

  membership = MembershipFee.find_or_initialize_by(year: year, half_year: true, membership_type: membership_type, new_member: false)
  membership.club_membership_fee = membership_fee/2
  membership.insurance_fee = insurance_fee/2
  membership.save!

  membership = MembershipFee.find_or_initialize_by(year: year, half_year: false, membership_type: membership_type, new_member: true)
  membership.club_membership_fee = membership_fee + new_member_fee
  membership.insurance_fee = insurance_fee
  membership.save!

  membership = MembershipFee.find_or_initialize_by(year: year, half_year: true, membership_type: membership_type, new_member: true)
  membership.club_membership_fee = membership_fee/2 + new_member_fee
  membership.insurance_fee = insurance_fee/2
  membership.save!
end

create_membership_fee(2016, :senior,     91.00,   114.00,   40)
create_membership_fee(2016, :pensioner,  91.00/2, 114.00,   40)
create_membership_fee(2016, :student,    30.00,   114.00,   40)
create_membership_fee(2016, :junior,     0.00,    114.00/2, 40)

create_membership_fee(2017, :senior,     91.00,   114.00,   40)
create_membership_fee(2017, :pensioner,  91.00/2, 114.00,   40)
create_membership_fee(2017, :student,    30.00,   114.00,   40)
create_membership_fee(2017, :junior,     0.00,    114.00/2, 40)

create_membership_fee(2018, :senior,     1.00,    114.00,   40)
create_membership_fee(2018, :pensioner,  1.00,    114.00,   40)
create_membership_fee(2018, :student,    1.00,    114.00,   40)
create_membership_fee(2018, :junior,     1.00,    114.00/2, 40)
