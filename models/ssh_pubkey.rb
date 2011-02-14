require 'gitolite'
require 'gitolite_helper'

class SshPubkey < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :pubkey

  def after_save
    ga = RetroGitolite::GitoliteAdmin.instance.repo
    ga.add_key(self.key)
    ga.save_and_apply
    ga.gl_admin.git.push
  end

  def before_destroy
    ga = RetroGitolite::GitoliteAdmin.instance.repo
    ga.rm_key(self.key)
    ga.save_and_apply
    ga.gl_admin.git.push
  end

  def filename
    return "#{ user.scm_name }@#{ id }.pub"
  end

  protected
  def key
    type, blob, comment = self.pubkey.split
    k = Gitolite::SSHKey.new type, blob, comment
    k.owner = self.user.scm_name
    k.location = "#{ id }"
    k
  end
end
