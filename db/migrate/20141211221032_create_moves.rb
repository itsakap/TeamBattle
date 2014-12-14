class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.string :move_choice, default: "defend"

      t.timestamps
    end
  end
end
