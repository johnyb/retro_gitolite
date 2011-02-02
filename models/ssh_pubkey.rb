require 'gitolite'
require 'gitolite_helper'

class SshPubkey < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :pubkey

  def after_save
    type, blob, comment = self.pubkey.split
    key = Gitolite::SSHKey.new type, blob, comment
    key.owner = user.scm_name
    key.location = "#{ id }"
    ga = RetroGitolite::GitoliteAdmin.instance.repo
    ga.add_key(key)
    ga.save_and_apply
  end
  def filename
    return "#{ user.scm_name }@#{ id }.pub"
  end
end
