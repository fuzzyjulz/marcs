class MembershipYearsController < ApplicationController
  respond_to :html
  helper_method :membership_year, :membership_fee
  
  def index
  end
  
  def renew
    authorize! :renew_membership, current_user

    if membership_year.present? and membership_year.club_rules_accepted
      return redirect_to(user_membership_year_fees_path(membership_year))
    end

    return unless membership_year.nil?

    @membership_year = MembershipYear.new
    membership_year.membership_type = current_user.membership_type_sym
    membership_year.pensioner_number = current_user.pensioner_number if current_user.membership_type_sym == :pensioner
    membership_year.student_number = current_user.student_number if current_user.membership_type_sym == :student
    
    membership_year.affiliate = current_user.affiliate?
    membership_year.affiliated_club = current_user.affiliated_club if current_user.affiliate?
    apply_member_details
  end

  def create
    authorize! :renew_membership, current_user

    @membership_year = MembershipYear.new() if membership_year.nil?
    membership_year.assign_attributes(membership_params)
    apply_member_details
    membership_year.student_number = nil unless membership_year.membership_type.to_sym == :student
    membership_year.pensioner_number = nil unless membership_year.membership_type.to_sym == :pensioner
    membership_year.affiliated_club = nil unless membership_year.affiliate
    
    membership_year.save
    
    if @membership_year.errors.any?
      flash[:alert] = @membership_year.errors.full_messages.to_sentence
      render :renew
    else
      redirect_to user_membership_year_fees_path(@membership_year)
    end
  end

  def apply_member_details
    membership_year.user = current_user
    membership_year.year = financial_year
    membership_year.half_year = financial_half_year?
    membership_year.life_member = current_user.life_member?
  end

  def fees
    authorize! :renew_membership, current_user
    return redirect_to(renew_user_membership_years_path) unless membership_year.user == current_user
    return redirect_to(user_membership_year_path(membership_year)) if membership_year.payment_date.present?
    
    @membership_fee = membership_year.membership_fee
    membership_year.update!(total_fees: @membership_fee)
    membership_year.payment_date = Date.today.strftime("%d/%m/%Y") 
  end
  
  def fees_back
    authorize! :renew_membership, current_user
    return redirect_to(renew_user_membership_years_path) unless membership_year.user == current_user
    
    membership_year.update!(club_rules_accepted: false)
    
    redirect_to(renew_user_membership_years_path)
  end
  
  def update
    authorize! :renew_membership, current_user
    return redirect_to(user_membership_year_renew_path) unless membership_year.user == current_user

    membership_year.update!(membership_update_params)
  end

  def update_back
    authorize! :renew_membership, current_user
    return redirect_to(renew_user_membership_years_path) unless membership_year.user == current_user
    
    membership_year.update!(payment_date: nil)

    redirect_to(user_membership_year_fees_path(membership_year))
  end

  def show
    render :update
  end

  def membership_year
    if @membership_year.nil?
      @membership_year = MembershipYear.find_by(user_id: current_user.id, year: financial_year, half_year: financial_half_year?)
    end
    @membership_year
  end
  
  def membership_params
    params.require(:membership_year).permit(
      :membership_type, :pensioner_number, :student_number,
      :affiliate, :affiliated_club, :club_rules_accepted)
  end

  def membership_update_params
    params.require(:membership_year).permit(:payment_authorised_number, :payment_date)
  end
end
