class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :trello_id, null: false, unique: true
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
