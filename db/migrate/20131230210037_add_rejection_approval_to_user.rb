class AddRejectionApprovalToUser < ActiveRecord::Migration
  def change
    add_column :users, :rejection, :text
    add_column :users, :approval, :text
  end
end
