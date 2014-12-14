class AddUserIdsToMoves < ActiveRecord::Migration
  def change
    add_reference :moves, :user, index: true
  end
end
