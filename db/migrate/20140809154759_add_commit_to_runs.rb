class AddCommitToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :commit, :string
  end
end
