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
  
  def junior?
    membership_type.to_sym == :junior
  end

  def member_marked_paid?
    confirmed_paid or !payment_date.nil?
  end

  def can_change?
    (!member_marked_paid? or updated_at > Date.yesterday) and !confirmed_paid
  end

  def year_range
    "#{year}-#{year+1}"
  end

  def membership_name
    "#{membership_type.to_s.titleize} #{life_member ? 'life':''} #{affiliate ? 'Affiliate':''}"
  end

  def membership_fee
    @fee_obj = MembershipFee.find_by(year: year, half_year: half_year, membership_type: membership_type, new_member: new_member) if @fee_obj.nil?
    @fee_obj
  end

  def club_fee
    life_member ? 0 : membership_fee.club_membership_fee
  end

  def insurance_fee
    affiliate ? 0 : membership_fee.insurance_fee
  end
  
  def total_fee
    club_fee + insurance_fee
  end
end
