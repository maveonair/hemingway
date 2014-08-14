class RenameGithubRepoNameToName < ActiveRecord::Migration
  def change
    rename_column :repositories, :name, :name
  end
end
