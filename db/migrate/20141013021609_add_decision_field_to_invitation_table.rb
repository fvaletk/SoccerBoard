class AddDecisionFieldToInvitationTable < ActiveRecord::Migration
  
  def up
  	add_column :invitations, :decision, :string, :default => 'none'
  end

  def down
  	remove_column :invitations, :decision
  end
end
