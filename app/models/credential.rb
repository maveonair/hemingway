class Credential < ActiveRecord::Base
  belongs_to :repository

  validates :repository, presence: true
  validates :passphrase, presence: true
  validates :private_key, presence: true
  validates :public_key, presence: true

  attr_encrypted :passphrase, key: Rails.application.secrets.ssh_passphrase
  attr_encrypted :private_key, key: Rails.application.secrets.ssh_private_key

  def generate_keys
    return if passphrase.present?
    generate_passphrase
    generate_ssh_keys
  end

  def self.build_with_keys
    Credential.new.tap do |credential|
      credential.generate_keys
    end
  end

  private

  def generate_passphrase
    self.passphrase = SecureRandom.hex
  end

  def generate_ssh_keys
    key = SSHKey.generate(passphrase: self.passphrase)
    self.private_key = key.private_key
    self.public_key = key.ssh_public_key
  end
end
