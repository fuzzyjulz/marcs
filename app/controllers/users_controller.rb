class UsersController < ApplicationController
  before_action :authenticate_user!
  helper_method :get_committee_members
  
  def home
  end
  
  def trainers
    authorize! :view_club_trainers, current_user
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
    Rails.cache.fetch("latest_member_refresh",expires_in: 1.day) do
      GoogleMember.get_all_members.each do |member|
        unless (member.nil?)
          User::save_from_member(member)
        end
      end
    end
    
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
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :street, :city, :postcode, :home_phone, :mobile_phone)
  end
end
