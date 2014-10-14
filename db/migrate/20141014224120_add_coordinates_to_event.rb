class AddCoordinatesToEvent < ActiveRecord::Migration
  
  def up
    add_column :events, :latitude, :decimal
    add_column :events, :longitude, :decimal
  end

  def down
    add_column :events, :latitude
    add_column :events, :longitude
  end
end
