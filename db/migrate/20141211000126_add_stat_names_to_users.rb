class AddStatNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hp, :integer
    add_column :users, :attack_power, :integer
    add_column :users, :heal_power, :integer
  end
end
