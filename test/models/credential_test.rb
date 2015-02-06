require 'test_helper'

class CredentialTest < ActiveSupport::TestCase
  test 'create a credential with keys' do
    credential = Credential.build_with_keys

    assert credential.passphrase.present?, true
    assert_match 'BEGIN RSA PRIVATE KEY', credential.private_key
    assert_match 'ssh-rsa', credential.public_key
  end
end
