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
end
