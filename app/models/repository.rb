class Repository < ActiveRecord::Base
  belongs_to :user
  has_many :runs, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true

  default_scope { order(name: :asc) }

  def unlocked?
    !locked?
  end

  def lock!
    update_attribute(:locked, true)
  end

  def unlock!
    update_attribute(:locked, false)
  end

  def github_url
    "https://github.com/#{name.downcase}"
  end
end
