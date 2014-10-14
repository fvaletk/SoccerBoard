class CreateEvents < ActiveRecord::Migration
  
  def up
    create_table :events do |t|
      t.integer :user_id
      t.integer :team_id
      t.string :subject
      t.text :description
      t.datetime :date, :default => Time.now
      t.string :token

      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
