class MembershipBatchesController < ApplicationController
  helper_method :members_in_batch, :batch_list
  
  def show
    authorize! :view_insurance_batches, current_user
    
    @financial_year = request[:id]
    @financial_year ||= renewal_financial_year
  end

  def create
    authorize! :create_insurance_batches, current_user
    
    @financial_year = request[:id]
    create_membership_batch
    redirect_to membership_batch_path(@financial_year)
  end
  
  def create_membership_batch
    unless @financial_year == renewal_financial_year.to_s
      flash[:alert] = "Cannot create batches for non current financial years(#{@financial_year})"
      return
    end
    
    members = members_in_batch(@financial_year, nil)
    if members.empty?
      flash[:alert] = "Cannot create batches for non current financial years(#{@financial_year})"
      return
    end
    
    batch = batch_list(@financial_year).compact.sort.last
    batch ||= 0
    batch = batch + 1
    
    members.each do |member|
      member.update!(batch: batch)
    end
    
    flash[:notice] = "Batch #{batch} created (#{members.size} members)."
  end
  
  def members_in_batch(year, batch)
    MembershipYear.where(year: year, confirmed_paid: true, batch: batch)
  end
  
  def batch_list(year)
    MembershipYear.where(year: year, confirmed_paid: true).distinct.order(batch: :desc).pluck(:batch)
  end
end
