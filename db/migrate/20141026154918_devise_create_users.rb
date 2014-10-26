class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :email,              null: false, default: ""
      t.string :name,               null: false, default: ""
      t.string :trello_uid,         null: false

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps
    end

    add_index :users, :email,                unique: true
    add_index :users, :trello_uid,                unique: true
  end
end
