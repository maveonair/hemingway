class AddExternalKeyIdToCredentials < ActiveRecord::Migration
  def change
    add_column :credentials, :external_key_id, :integer
  end
end
