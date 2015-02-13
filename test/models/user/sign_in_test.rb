require 'test_helper'

class User::SignInTest < ActiveSupport::TestCase
  test 'create a new user' do
    params = { provider: 'github', uid: '24' }
    params['info'] = { 'nickname' => 'murdock' }
    params['credentials'] =  { 'token' => 'abce3452' }
    params['extra'] = { 'raw_info' => { 'avatar_url' => 'http://placehold.it/100x100' } }

    sign_in = User::SignIn.new(params)
    user = sign_in.save!

    assert_match 'murdock', user.username
  end

  test 'return an existing user' do
    maveonair = users(:maveonair)
    sign_in = User::SignIn.new({ provider: maveonair.provider, uid: maveonair.uid })
    user = sign_in.save!

    assert_match maveonair.username, user.username
  end
end
