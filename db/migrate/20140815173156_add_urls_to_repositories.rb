class AddUrlsToRepositories < ActiveRecord::Migration
  def change
    add_column :repositories, :html_url, :string
    add_column :repositories, :ssh_url, :string
  end
end
