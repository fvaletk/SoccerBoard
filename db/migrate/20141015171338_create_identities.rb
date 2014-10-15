class CreateIdentities < ActiveRecord::Migration
  
  def up
    create_table :identities do |t|
      t.references :user, index: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end

  def down
    drop_table :identities
  end
end
