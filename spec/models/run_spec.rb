require 'rails_helper'

describe Run, type: :model do
  let(:phrase) { repositories(:phrase) }
  let(:last_run) { runs(:phrase_run) }

  it 'returns the latest run' do
    phrase.runs.create!(author: 'Angus Macgyver', revision: '1234ABCD')
    phrase.runs.create!(author: 'Angus Macgyver', revision: 'ABCD1234')

    expect(phrase.latest_run.revision).to eq('ABCD1234')
  end

  it 'returns true that a run exists' do
    expect(Run.exist?(last_run.revision)).to be_truthy

    expect(Run.exist?('1234ABCD')).to be_falsy
    phrase.runs.create!(author: 'Angus Macgyver', revision: '1234ABCD')
    expect(Run.exist?('1234ABCD')).to be_truthy
  end

  it 'returns the summary of a run' do
    summary = last_run.summary
    expect(summary.offenses?).to be_truthy
    expect(summary.total_offenses).to eq(56)
    expect(summary.total_files).to eq(17)
    expect(summary.total_inspected_files).to eq(17)
  end
end
