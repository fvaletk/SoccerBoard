class CreateEventParticipants < ActiveRecord::Migration
 
  def up
    create_table :event_participants do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :status, :default => "pending"

      t.timestamps
    end
  end

  def down
  	drop_table :event_participants
  end
end
