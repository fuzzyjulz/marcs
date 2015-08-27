class Api::V1::SessionsController < Devise::SessionsController  
  def create
    fai = @_params["user"]["fai"]
    
    user = User.where(fai: fai)
    if user.empty?
      create_user_for_fai(fai)
    else
      #Check that details don't need to be updated...
    end
      
    super
  end
  
  def create_user_for_fai(fai)
    member = GoogleMember.get_member_by_fai(fai)
    unless (member.nil?)
      newuser = User.new({
        password: member.last_name,
        password_confirmation: member.last_name
      }.merge(member.attributes_to_user))
      newuser.save!(validate: false)
    end
  end
end