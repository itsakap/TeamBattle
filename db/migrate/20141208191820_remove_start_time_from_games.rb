class RemoveStartTimeFromGames < ActiveRecord::Migration
  def change
    remove_column :games, :start_time, :datetime
  end
end
