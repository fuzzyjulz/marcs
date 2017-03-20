class Ability
  include CanCan::Ability
    
  def initialize(user)
    unless user.nil?
      if user.financial?
        can [:view_committee_members, :view_club_trainers, :view_minutes], User
      end
      if user.committee_member?
        can [:view_committee_calendar], User
      end
    end
  end
end
