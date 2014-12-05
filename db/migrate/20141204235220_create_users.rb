class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.integer :attack_power, default:20
      t.integer :hp, default:200
      t.integer :heal_power, default:20
      t.boolean :captain?, default: false
      t.boolean :eliminated?, default: false

      t.timestamps
    end
  end
end
