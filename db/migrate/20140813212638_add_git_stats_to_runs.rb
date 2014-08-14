class AddGitStatsToRuns < ActiveRecord::Migration
  def change
    add_column :runs, :author, :string
    add_column :runs, :log, :text
    rename_column :runs, :commit, :revision
  end
end
