class Repository < ActiveRecord::Base
  has_many :runs, dependent: :destroy

  validates :github_repo_name, presence: true, uniqueness: true

  default_scope { order(github_repo_name: :asc) }

  def unlocked?
    !locked?
  end

  def lock!
    update_attribute(:locked, true)
  end

  def unlock!
    update_attribute(:locked, false)
  end

  def github_repository_url
    "https://github.com/#{github_repo_name.downcase}"
  end
end
