require 'test_helper'

class RepositoryTest < ActiveSupport::TestCase
  test 'lock the repository' do
    phrase = repositories(:phrase)

    assert_not phrase.locked?
    phrase.lock!
    assert phrase.locked?
  end

  test 'unlock the repository' do
    kado = repositories(:kado)

    assert kado.locked?
    kado.unlock!
    assert_not kado.locked?
  end
end
