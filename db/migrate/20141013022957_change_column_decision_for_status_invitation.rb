class ChangeColumnDecisionForStatusInvitation < ActiveRecord::Migration
 
  def up
  	rename_column :invitations, :decision, :status
  	change_column :invitations, :status, :string, :default => "pending"
  end

  def down
  	change_column :invitations, :status, :string, :default => "none"
  	rename_column :invitations, :status, :decision
  end
end
