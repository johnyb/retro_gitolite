class SshPubkey < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :pubkey
end
