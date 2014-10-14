class AddDefaultToValidColumnInvitations < ActiveRecord::Migration
  
  def up
    change_column :invitations, :valid, :boolean, :default => true
  end

  def down
    change_column :invitations, :valid
  end
end
