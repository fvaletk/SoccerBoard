class AddStatusFieldToTransferOwnership < ActiveRecord::Migration
  
  def up
    add_column :transfer_ownerships, :status, :string, :default => "pending"
  end

  def down
    remove_column :transfer_ownerships, :status
  end
end
