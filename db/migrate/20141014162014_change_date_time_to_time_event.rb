class ChangeDateTimeToTimeEvent < ActiveRecord::Migration
  
  def up
    change_column :events, :date, :time
  end

  def down
    change_column :events, :date, :datetime
  end
end
