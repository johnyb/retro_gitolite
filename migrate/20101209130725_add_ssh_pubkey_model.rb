class AddSshPubkeyModel < ActiveRecord::Migration
  def self.up
    create_table :ssh_pubkeys do |t|
      t.references :user, :null => false
      t.text :pubkey, :null => false

      t.timestamps
    end

  end

  def self.down
    drop_table :ssh_pubkeys
  end
end
