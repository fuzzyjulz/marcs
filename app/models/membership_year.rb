class MembershipYear < ActiveRecord::Base
  belongs_to :user
  
  validates :pensioner_number, presence: true, if: :pensioner?
  validates :student_number, presence: true, if: :student?
  validates :affiliated_club, presence: true, if: :affiliate
  
  def pensioner?
    membership_type.to_sym == :pensioner
  end

  def student?
    membership_type.to_sym == :student
  end
  
  def can_change?
    payment_date.nil? or updated_at > Date.yesterday
  end

  def year_range
    "#{year}-#{year+1}"
  end

  def membership_name
    "#{membership_type.to_s.titleize} #{life_member ? 'life':''} #{affiliate ? 'Affiliate':''}"
  end

  def membership_fee
    fee_obj = MembershipFee.find_by(year: year, half_year: half_year, membership_type: membership_type)
    fee = 0
    fee += fee_obj.club_membership_fee unless life_member
    fee += fee_obj.insurance_fee unless affiliate
    fee
  end
end
