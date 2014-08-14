class RenameGithubRepoNameToName < ActiveRecord::Migration
  def change
    rename_column :repositories, :github_repo_name, :name
  end
end
