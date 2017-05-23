class MembershipYearsController < ApplicationController
  respond_to :html
  
  def renew
    authorize! :renew_membership, current_user
    
    @membership_year = MembershipYear.new if @membership_year.nil?
    @membership_year.membership_type = current_user.membership_type_sym
    @membership_year.pensioner_number = current_user.pensioner_number if current_user.membership_type_sym == :pensioner
    @membership_year.student_number = current_user.student_number if current_user.membership_type_sym == :student
    
    @membership_year.affiliate = current_user.affiliate?
    @membership_year.affiliated_club = current_user.affiliated_club if current_user.affiliate?
    apply_member_details

    existing_member = MembershipYear.find_by(user_id: current_user.id, year: @membership_year.year, half_year: @membership_year.half_year)
    if existing_member.present? and existing_member.club_rules_accepted
      redirect_to user_membership_year_fees_path(existing_member)
    end
  end

  def create
    authorize! :renew_membership, current_user

    @membership_year = MembershipYear.new(membership_params)
    apply_member_details
    @membership_year.save
    
    if @membership_year.errors.any?
      flash[:alert] = @membership_year.errors.full_messages.to_sentence
      render :renew
    else
      redirect_to user_membership_year_fees_path(@membership_year)
    end
  end

  def apply_member_details
    @membership_year.user = current_user
    @membership_year.year = Date.today.year
    @membership_year.half_year = false
    @membership_year.life_member = current_user.life_member?
  end

  def fees
    authorize! :renew_membership, current_user
  end

  def membership_params
    params.require(:membership_year).permit(
      :membership_type, :pensioner_number, :student_number,
      :affiliate, :affiliated_club, :club_rules_accepted)
  end

end