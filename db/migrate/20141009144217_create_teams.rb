class CreateTeams < ActiveRecord::Migration
  
  def up
    create_table :teams do |t|
      t.string :team_name
      t.integer :user_id

      t.timestamps
    end
  end

  def down
      drop_table :teams
  end
end
