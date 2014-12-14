class AddStartedToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :started?, :boolean, default: false
  end
end
