class Api::V1::PasswordsController < Devise::PasswordsController  
  def update
    request.params["user"]["password"] = request.params["user"]["password"].downcase
    request.params["user"]["password_confirmation"] = request.params["user"]["password_confirmation"].downcase
    
    super
    
    self.resource.unlock_access!
  end
end
