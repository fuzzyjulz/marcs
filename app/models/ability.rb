class Ability
  include CanCan::Ability
    
  def initialize(user)
    unless user.nil?
      if user.financial?
        can [:view_committee_members, :view_club_trainers, :view_minutes], User
        can [:view_club_minutes,:view_agm_minutes], Minutes
        if user.committee_member?
          can [:view_committee_calendar], User
          can [:view_committee_minutes], Minutes
        end
      end
    end
  end
end
