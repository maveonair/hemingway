class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.integer :sequence
      t.boolean :passed
      t.text :result
      t.references :repository

      t.timestamps
    end
  end
end
