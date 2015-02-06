class AddSequenceToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :sequence, :integer
  end
end
