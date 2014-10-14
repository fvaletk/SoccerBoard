class FisIssuesInEvent < ActiveRecord::Migration
  
  def up
    remove_column :events, :date
    add_column :events, :date, :datetime
  end

  def down
    remove_column :events, :date
    add_column :events, :date, :time
  end

end
