require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @params = { provider: 'github', uid: '24' }
    @params['info'] = { 'nickname' => 'murdock' }
    @params['credentials'] =  { 'token' => 'abce3452' }
    @params['extra'] = { 'raw_info' => { 'avatar_url' => 'http://placehold.it/100x100' } }
  end

  test 'creates a new user' do
    assert_not User.find_by_username('murdock')
    sign_in = User::SignIn.new(@params)

    assert sign_in.user.username, 'murdock'
  end

  test 'finds an existing user' do
    maveonair = users(:maveonair)

    params = { provider: maveonair.provider, uid: maveonair.uid }
    sign_in = User::SignIn.new(params)

    assert sign_in.user.username, maveonair.username
  end
end

