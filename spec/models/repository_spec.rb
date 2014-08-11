require 'rails_helper'

describe Repository, :type => :model do
  let (:phrase) { repositories(:phrase) }
  let (:kado) { repositories(:kado) }

  it 'locks the repository' do
    expect(phrase.locked?).to be false

    phrase.lock!
    expect(phrase.locked?).to be true
  end

  it 'unlocks the repository' do
    expect(kado.locked?).to be true
    kado.unlock!
    expect(kado.locked?).to be false
  end
end
