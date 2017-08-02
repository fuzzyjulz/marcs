class Ability
  include CanCan::Ability
    
  def initialize(user)
    unless user.nil?
      can [:view_committee_members, :view_member_area], User
      can [:renew_membership], User unless user.non_renewal?
      if user.financial?
        can [:view_club_trainers, :view_minutes], User
        can [:view_club_minutes,:view_agm_minutes], Minutes
        if user.committee_member?
          can [:view_committee_calendar], User
          can [:view_committee_minutes], Minutes
          if user.committee_executive?
            can [:refresh_album, :delete_album], Album
            can [:view_commitee_area, :view_member_renewals, :update_member_renewals, :view_insurance_batches], User
            can [:create_insurance_batches], User
          end
        end
      end
    end
  end
end
