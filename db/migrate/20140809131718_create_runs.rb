class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.boolean :passed
      t.text :result
      t.references :repository, index: true

      t.timestamps
    end
  end
end
