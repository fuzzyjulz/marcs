class MembershipController < ApplicationController
  def new
    authorize! :renew_membership, current_user
  end
end
