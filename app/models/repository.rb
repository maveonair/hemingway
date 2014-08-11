class Repository < ActiveRecord::Base
  has_many :runs

  validates :github_repo_name, :presence => true, :uniqueness => true

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
    "https://github.com/#{github_repo_name.downcase}"
  end
end
