require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:macgyver) { users(:macgyver) }

  context 'Sign In' do
    before do
      @params = { provider: 'github', uid: '24' }
      @params['info'] = { 'nickname' => 'murdock' }
      @params['credentials'] =  { 'token' => 'abce3452' }
      @params['extra'] = { 'raw_info' => { 'avatar_url' => 'http://placehold.it/100x100' } }
    end

    it 'creates a new user' do
      expect(User.find_by_username('murdock')).to be_nil
      sign_in = User::SignIn.new(@params)
      expect(sign_in.user.username).to eq('murdock')
    end

    it 'finds an existing user' do
      params = { provider: macgyver.provider, uid: macgyver.uid }
      sign_in = User::SignIn.new(params)
      expect(sign_in.user.username).to eq(macgyver.username)
    end
  end
end
