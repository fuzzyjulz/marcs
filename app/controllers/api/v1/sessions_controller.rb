class Api::V1::SessionsController < Devise::SessionsController  
  def create
    fai = @_params["user"]["fai"]
    request.params["user"]["password"] = request.params["user"]["password"].downcase
    
    user = User.where(fai: fai)
      
    super
  end
end