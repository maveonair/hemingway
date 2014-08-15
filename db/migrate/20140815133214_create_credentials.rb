class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.string :encrypted_passphrase
      t.text :encrypted_private_key
      t.text :public_key
      t.references :repository, index: true

      t.timestamps
    end
  end
end
