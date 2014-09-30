class Repository::Github::ContentService < Repository::Github::Service
  def contents(repository_name, revision, file_path)
    octokit.contents(repository_name, ref: revision, path: file_path)
  end
end
