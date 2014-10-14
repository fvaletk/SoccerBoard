class CreateUserTeams < ActiveRecord::Migration
  
  def up
    create_table :user_teams do |t|
      t.integer :user_id
      t.integer :team_id
      t.integer :t_shirt_number
      t.string :nickname

      t.timestamps
    end
  end

  def down
    drop_table :user_teams
  end
end
