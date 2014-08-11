class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :github_repo_name

      t.timestamps
    end
  end
end
