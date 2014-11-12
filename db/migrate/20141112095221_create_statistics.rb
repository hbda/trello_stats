class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.references :board
      t.string :data

      t.timestamps
    end
  end
end
