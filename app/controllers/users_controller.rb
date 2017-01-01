class UsersController < ApplicationController
  before_action :authenticate_user!
  helper_method :get_committee_members
  
  def home
  end
  
  def update
    current_user.update!(user_params)

    if current_user.changed_member_fields.empty?
      flash[:notice]="No change"
    else
      MarcsMailer.member_details_update(current_user).deliver_now
      
      flash[:notice]="Updated your details"
    end
    redirect_to home_user_path
  end
  
  def refresh
    last_updated_member = User.order("updated_at desc").first
    
    if (last_updated_member.updated_at > Date.yesterday)
      stats
      render layout: nil
      return
    end
    
    GoogleMember.get_all_members.each do |member|
      unless (member.nil?)
        User::save_from_member(member)
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
