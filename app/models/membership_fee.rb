class MembershipFee < ActiveRecord::Base
  def fee_name
    "#{new_member ? "New" : "Existing" } #{membership_type.to_s} #{half_year ? 'half year':'full year'}"
  end
end
