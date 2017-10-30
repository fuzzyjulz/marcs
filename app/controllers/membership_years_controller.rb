class MembershipYearsController < ApplicationController
  respond_to :html
  helper_method :membership_year, :membership_fee
  
  def index
    authorize! :view_member_renewals, current_user
  end
  
  def admin_paid
    authorize! :update_member_renewals, current_user
    
    params = admin_membership_update_params
    params[:confirmed_paid] = true
    
    membership_year = MembershipYear.find(request[:membership_year_id]).update!(params)
    flash[:notice] = "Updated payment date"
    return redirect_to(membership_years_path)
  end
  
  def admin_paid_revert
    authorize! :update_member_renewals, current_user
    
    membership_year = MembershipYear.find(request[:membership_year_id]).update!(confirmed_paid: false)
    flash[:notice] = "Reverted payment confirmation"
    return redirect_to(membership_years_path)
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
    
    @membership_fee = membership_year.total_fee
    membership_year.update!(total_fees: @membership_fee)
    membership_year.payment_date = Date.today.strftime("%d/%m/%Y") 
  end
  
  def new_member_fees
    authorize! :create_member, current_user
    @user = User.find(request[:user_id])
    @membership_year = MembershipYear.new() if @membership_year.nil?

    membership_year.year = financial_year
    membership_year.half_year = financial_half_year?

    unless @user.membership_years.empty?
      flash[:alert] = "Membership has been recorded, so this member is no longer a new member"
      return redirect_to(home_user_path)
    end
  end
  
  def new_member_fees_create
    authorize! :create_member, current_user
    @user = User.find(request[:user_id])
    unless @user.membership_years.empty?
      flash[:alert] = "Membership has been recorded, so this member is no longer a new member"
      return redirect_to(home_user_path)
    end

    @membership_year = MembershipYear.new() if @membership_year.nil?
    membership_year.assign_attributes(membership_params)
    membership_year.user = @user
    
    if membership_year.membership_type.nil?
      flash[:alert] = "Membership type is required"
      return redirect_to(new_member_fees_user_membership_years_path(@user))
    end

    if membership_year.affiliate.nil?
      flash[:alert] = "Affiliate is required"
      return redirect_to(new_member_fees_user_membership_years_path(@user))
    end
    
    membership_year.affiliate = (membership_year.affiliate.nil? ? nil : membership_year.affiliate == true)
    membership_year.student_number = nil unless membership_year.membership_type.to_sym == :student
    membership_year.pensioner_number = nil unless membership_year.membership_type.to_sym == :pensioner
    membership_year.affiliated_club = nil unless membership_year.affiliate

    membership_year.year = financial_year
    membership_year.half_year = financial_half_year?
    membership_year.life_member = false
    membership_year.new_member = true
    membership_year.club_rules_accepted = true
    
    membership_year.total_fees = membership_year.total_fee

    membership_year.save

    if membership_year.errors.any?
      flash[:alert] = membership_year.errors.full_messages.to_sentence
      render :new_member_fees
    else
      flash[:notice] = "New member has been added successfully"
      redirect_to new_member_fees_saved_user_membership_years_path(@user)
    end
  end

  def new_member_fees_saved
    @user = User.find(request[:user_id])
    @membership_year = @user.membership_years.first
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
      @membership_year = MembershipYear.find_by(user_id: current_user.id, year: financial_year)
    end
    @membership_year
  end
  
  def membership_params
    _params = params.require(:membership_year).permit(
      :membership_type, :pensioner_number, :student_number,
      :affiliate, :affiliated_club, :club_rules_accepted)
    _params["affiliate"] = (_params["affiliate"].nil? ? nil : _params["affiliate"] == "true")
    _params
  end

  def membership_update_params
    params.require(:membership_year).permit(:payment_authorised_number, :payment_date)
  end

  def admin_membership_update_params
    params.require(:membership_year).permit(:payment_date)
  end
end
