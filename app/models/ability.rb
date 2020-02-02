class Ability
  include CanCan::Ability
    
  def initialize(user)
    unless user.nil? or user.sign_in_count <= 1
      can [:view_committee_members, :view_member_area], User
      can [:renew_membership, :logout, :change_password], User unless user.non_renewal?
      if user.financial? or user.committee_member?
        can [:view_club_trainers, :view_minutes], User
        can [:view_club_minutes,:view_agm_minutes, :view_committee_minutes], Minutes
        if user.committee_member?
          can [:view_committee_calendar], User
          if user.committee_executive?
            can [:refresh_album, :delete_album], Album
            can [:view_commitee_area, :view_member_renewals, :update_member_renewals, :view_insurance_batches, :view_member_list], User
            can [:create_member], User
            can [:create_insurance_batches], User
          end
        end
      end
    end
  end
end
