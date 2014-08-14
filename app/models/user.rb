class User < ActiveRecord::Base
  has_many :repositories, dependent: :destroy
end
