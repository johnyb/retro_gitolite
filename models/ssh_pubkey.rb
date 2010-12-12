class SshPubkey < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :pubkey

  def filename
    return "#{ user.scm_name }@#{ id }.pub"
  end
end
