class Ability
  include CanCan::Ability
    
  def initialize(user)
    unless user.nil?
      can [:view_committee_members, :view_member_area], User
      if user.financial?
        can [:view_club_trainers, :view_minutes], User
        can [:view_club_minutes,:view_agm_minutes], Minutes
        if user.first_name.downcase == "julian"
          can [:renew_membership], User unless user.non_renewal?
        end
        if user.committee_member?
          can [:view_committee_calendar], User
          can [:view_committee_minutes], Minutes
        end
      end
    end
  end
end
