class AddFieldsToInvitationTable < ActiveRecord::Migration
  
  def up
    rename_column :invitations, :email, :recipient_email
    add_column :invitations, :token, :string
    add_column :invitations, :valid, :boolean
    add_column :invitations, :team_id, :integer
  end

  def down
    rename_column :invitations, :recipient_email
    remove_column :invitations, :token
    remove_column :invitations, :valid
    remove_column :invitations, :team_id
  end

end
