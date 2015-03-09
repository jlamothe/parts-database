class AddAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, required: true, default: false
  end
end
