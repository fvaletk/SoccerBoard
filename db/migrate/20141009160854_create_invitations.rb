class CreateInvitations < ActiveRecord::Migration
  
  def up
    create_table :invitations do |t|
      t.integer :user_id
      t.string :email

      t.timestamps
    end
  end

  def down
    drop_table :invitations
  end
end
