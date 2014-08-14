class GitWrapper
  def initialize(working_directory)
    @working_directory = working_directory
  end

  def checkout(url)
    Dir.chdir(@working_directory) do
      git_clone = "git clone #{url} #{@working_directory}"
      system(*git_clone)

      OpenStruct.new(author: author, revision: head_revision, log: log)
    end
  end

  private

  def author
    `git show --format="%aN <%aE>" -s`.strip
  end

  def head_revision
    `git rev-parse HEAD`.strip
  end

  def log
    `git show -s --format=%B`.strip
  end
end
