class AddDeltasToUsers < ActiveRecord::Migration
  def change
    add_column :users, :x, :integer, default:0
    add_column :users, :y, :integer, default:0
    add_column :users, :z, :integer, default:0
  end
end
