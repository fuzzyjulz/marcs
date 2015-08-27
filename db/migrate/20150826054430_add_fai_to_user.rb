class AddFaiToUser < ActiveRecord::Migration
  def change
    add_column(:users, :fai, :string)
  end
end
