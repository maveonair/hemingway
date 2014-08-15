class GitWrapper
  def initialize(repository, working_directory)
    @repository = repository
    @working_directory = working_directory
  end

  def clone
    begin
      repository = Rugged::Repository.clone_at(@repository.ssh_url,
                                               @working_directory,
                                               { credentials: ssh_key })
      last_commit(repository)
    ensure
      cleanup
    end
  end

  private

  def last_commit(repository)
    author = repository.last_commit.author[:name]
    revision = repository.last_commit.oid
    log = repository.last_commit.message

    OpenStruct.new(author: author, revision: revision, log: log)
  end

  def ssh_key
    Rugged::Credentials::SshKey.new(username: 'git',
                                    publickey: public_key_file.path,
                                    privatekey: private_key_file.path,
                                    passphrase: credentials.passphrase)

  end

  def private_key_file
    @private_key_file ||= temp_key_file(credentials.private_key)
  end

  def public_key_file
    @public_key_file ||= temp_key_file(credentials.public_key)
  end

  def temp_key_file(key)
    Tempfile.new(SecureRandom.hex).tap do |file|
      # Use puts here to write the key properly
      file.puts(key)
      file.flush
    end
  end

  def credentials
    @repository.credential
  end

  def cleanup
    private_key_file.close
    private_key_file.unlink

    public_key_file.unlink
    public_key_file.unlink
  end
end
