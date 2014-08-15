require 'rails_helper'

RSpec.describe Credential, type: :model do
  it 'creates a credential with keys' do
    credential = Credential.build_with_keys

    expect(credential.passphrase.present?).to be true
    expect(credential.private_key).to include('BEGIN RSA PRIVATE KEY')
    expect(credential.public_key).to include('ssh-rsa')
  end
end
