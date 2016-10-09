class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def home
  end
  
  def edit
  end
end
