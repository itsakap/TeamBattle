class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.boolean :eliminated?, default: false

      t.timestamps
    end
  end
end
