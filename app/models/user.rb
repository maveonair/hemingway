class User < ActiveRecord::Base
  has_many :repositories, dependent: :destroy

  validates :username, :token, :provider, :uid, presence: true
end
