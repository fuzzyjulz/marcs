class UsersController < ApplicationController
  before_action :authenticate_user!
  helper_method :get_committee_members
  
  def home
    if current_user.sign_in_count <= 1
      redirect_to change_password_user_path
    end
  end
  
  def change_password
  end
  
  def new
    authorize! :create_member, current_user
    @user = User.new
  end
  
  def create
    authorize! :create_member, current_user
    
    params = create_user_params
    temp_pwd = Devise.friendly_token.first(8)
    params[:password] = temp_pwd
    params[:password_confirmation] = temp_pwd

    @user = User.find_by(fai: params[:fai])
    unless @user.nil?
      redirect_to new_member_fees_user_membership_years_path(@user)
      return
    end
    
    @user = User.create(params)

    if @user.errors.any?
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :new
      return
    end
    
    @user.password = @user.last_name.downcase
    @user.password_confirmation = @user.password.downcase
    @user.save!(validate: false)

    redirect_to new_member_fees_user_membership_years_path(@user)
  end

  def trainers
    authorize! :view_club_trainers, current_user
  end
  
  def update_change_password
    current_user.assign_attributes(user_change_pw_params)
    
    #sign in count will be used to force the member to update their password the first time they login.
    current_user.sign_in_count = 2 if current_user.sign_in_count <= 1
    
    if current_user.password != current_user.password_confirmation
      flash[:alert] = "Confirmed password and password must match."

      redirect_to change_password_user_path
      return
    end
    
    current_user.password = current_user.password.downcase
    current_user.password_confirmation = current_user.password_confirmation.downcase
    
    current_user.save
    if current_user.errors.present?
      flash[:alert] = current_user.errors.full_messages.join(",")

      redirect_to change_password_user_path
    else
      flash[:notice]="Updated your password"
  
      redirect_to home_user_path
    end
  end

  def update
    current_user.update!(user_params)

    if current_user.changed_member_fields.empty?
      flash[:notice]="No change"
    else
      mail = MarcsMailer.member_details_update(current_user)
      mail.deliver_now unless Rails.env.test?
      
      flash[:notice]="Updated your details"
    end
    redirect_to home_user_path
  end
  
  def refresh
    stats
    render layout: nil
  end
  
  def get_committee_members
    User::get_committee_members
  end
  
 private
  def stats
    @last_updated_date = User.order("updated_at desc").first.updated_at
    @member_count = User.count
    @active_member_count = User.financial_memebers.count
  end
  
  def user_change_pw_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:first_name, :known_by, :last_name, :email, :street, :city, :postcode, :home_phone, :mobile_phone)
  end

  def create_user_params
    params.require(:user).permit(:fai, :first_name, :known_by, :last_name, :email, :street, :city, :postcode, :home_phone, :mobile_phone)
  end
end
