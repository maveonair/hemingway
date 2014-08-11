class AddLockedToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :locked, :boolean, :default => false
  end
end
