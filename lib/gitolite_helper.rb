require 'gitolite'

module RetroGitolite
  class GitoliteAdmin
    attr_reader :repo

    include Singleton

    def initialize
      path = Repository.find_by_name( RetroCM[:repositories][:repo_git][:repo] ).path
      @repo = Gitolite::GitoliteAdmin.new(path)
    end
  end
end
