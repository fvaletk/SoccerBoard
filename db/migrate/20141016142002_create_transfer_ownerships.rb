class CreateTransferOwnerships < ActiveRecord::Migration
  
  def up
    create_table :transfer_ownerships do |t|
      t.integer :user_id
      t.integer :team_id
      t.string :token
      t.timestamps
    end
  end

  def down
    drop_table :transfer_ownerships
  end
end
