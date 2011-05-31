require 'spec_helper'

describe "SshPubkey" do
  let(:pubkey_blob){ File.read(Spec::Runner.configuration.fixture_path + "id_rsa.pub") }
  let(:valid_key){ SshPubkey.new.pubkey = pubkey_blob }

  context "validations" do

    it "should fail without pubkey data" do
       p = SshPubkey.new
       p.should_not be_valid
    end

    it "should be valid with pubkey data" do
      p = SshPubkey.new
      p.pubkey = pubkey_blob
      p.should be_valid
    end
  end

  context "syncs with repo" do

    before(:each) do
      mock(Repository)
      Repository.should_receive(:find_by_name).with("gitolite-admin").and_return(Repository.new)
      Repository.should_receive(:path).and_return(Spec::Runner.configuration.fixture_path + "gitolite-admin")
    end

    it "should store the key in defined repo" do
      p = valid_key
      ga = RetroGitolite::GitoliteAdmin.instance.repo
      #ga.keys.contains
    end
  end
end
