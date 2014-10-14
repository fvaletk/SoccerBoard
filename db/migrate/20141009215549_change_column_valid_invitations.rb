class ChangeColumnValidInvitations < ActiveRecord::Migration
  
  def up
    rename_column :invitations, :valid, :valid_invitation
  end

  def down
    rename_column :invitations, :valid_invitation, :valid
  end
end
