class AddUserReferenceToRepositories < ActiveRecord::Migration
  def change
    add_reference :repositories, :user, index: true
  end
end
