class User < ActiveRecord::Base
  has_many :repositories, dependent: :destroy

  validates_presence_of :username, :token, :provider, :uid
end
