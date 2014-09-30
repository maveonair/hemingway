class Repository < ActiveRecord::Base
  belongs_to :user

  has_one :credential, dependent: :destroy
  has_many :runs, dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true

  default_scope { order(name: :asc) }

  delegate :latest_run, to: :runs

  def unlocked?
    !locked?
  end

  def lock!
    update_attribute(:locked, true)
  end

  def unlock!
    update_attribute(:locked, false)
  end
end
