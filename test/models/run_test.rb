require 'test_helper'

class RunTest < ActiveSupport::TestCase
  test 'return the latest run' do
    phrase = repositories(:phrase)
    phrase.runs.create!(author: 'Fabian Mettler', revision: '1234ABCD')
    phrase.runs.create!(author: 'Fabian Mettler', revision: 'ABCD1234')

    assert phrase.latest_run.revision, 'ABCD1234'
  end

  test 'return true that a run exists' do
    last_run = runs(:phrase_run)

    assert Run.revision?(last_run.revision)
    assert_not Run.revision?('1234ABCD')

    phrase = repositories(:phrase)
    phrase.runs.create!(author: 'Fabian Mettler', revision: '1234ABCD')

    assert Run.revision?('1234ABCD')
  end
end



