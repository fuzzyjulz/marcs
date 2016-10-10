class Api::V1::SessionsController < Devise::SessionsController  
  def create
    fai = @_params["user"]["fai"]
    request.params["user"]["password"] = request.params["user"]["password"].downcase
    
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
      User::save_from_member(member)
    end
  end
end