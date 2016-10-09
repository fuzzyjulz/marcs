class UserWing < ActiveRecord::Base
  belongs_to :user
  
  WING_TYPES = ["Gold", "Bronze", "-"]
end