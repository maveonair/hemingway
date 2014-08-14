class User::SignIn
  def initialize(params)
    @params = params
  end

  def user
    find_user || create_with_omniauth
  end

  private

  def find_user
    User.find_by_provider_and_uid(@params['provider'], @params['uid'])
  end

  def create_with_omniauth
    User.create! do |user|
      user.provider = @params['provider']
      user.uid = @params['uid']
      user.username = @params['info']['nickname']
      user.token = @params['credentials']['token']
      user.avatar_url = @params['extra']['raw_info']['avatar_url']
    end
  end
end
