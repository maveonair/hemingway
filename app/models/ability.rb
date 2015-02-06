class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user
    set_abilities
  end

  private

  def set_abilities
    can [:update, :destroy], User do |user|
      user.try(:id) == @user.id
    end

    set_repositories_ability
    set_runs_ability
  end

  def set_repositories_ability
    can [:create, :choose_account], Repository
    can [:read, :destroy, :settings], Repository, user_id: @user.id

    can :start_run, Repository do |repository|
      repository.try(:user_id) == @user.id
    end
  end

  def set_runs_ability
    can [:read, :inspect], Run, repository: { user_id: @user.id }
  end
end
