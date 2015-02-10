class User::SignIn
  def initialize(params)
    @params = params
  end

  def save!
    find_user || create_with_omniauth!
  end

  private

  attr_reader :params

  def find_user
    User.find_by_provider_and_uid(provider, uid)
  end

  def create_with_omniauth!
    User.new.tap do |user|
      user.provider = provider
      user.uid = uid
      user.username = username
      user.token = token
      user.avatar_url = avatar_url
      user.save!
    end
  end

  def provider
    params[:provider]
  end

  def uid
    params[:uid]
  end

  def username
    params['info']['nickname']
  end

  def token
    params['credentials']['token']
  end

  def avatar_url
    params['extra']['raw_info']['avatar_url']
  end
end
