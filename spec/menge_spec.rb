require "spec_helper"

RSpec.describe Menge do
  context 'flat set' do
    it { expect(Menge::And[1, 2].contained?(Menge::Set[1, 2, 3])).to be_truthy }
    it { expect(Menge::And[1, 2].contained?(Menge::Set[1, 3])).to eq false }
    it { expect(Menge::Or[1, 2].contained?(Menge::Set[1, 2, 3])).to be_truthy }
    it { expect(Menge::Or[1, 2].contained?(Menge::Set[1, 3])).to be_truthy }
    it { expect(Menge::Or[1, 2].contained?(Menge::Set[0, 3])).to eq false }
    it { expect(Menge::Not[1, 2].contained?(Menge::Set[1, 2, 3])).to eq false }
    it { expect(Menge::Not[1, 2].contained?(Menge::Set[3])).to be_truthy }
  end

  context 'nested set' do
    it { expect(Menge::And[1, Menge::Or[2, 3]].contained?(Menge::Set[1, 2])).to be_truthy }
    it { expect(Menge::And[1, Menge::Or[2, 3]].contained?(Menge::Set[1, 3])).to be_truthy }
    it { expect(Menge::And[1, Menge::Or[2, 3]].contained?(Menge::Set[2, 3])).to eq false }
    it { expect(Menge::Not[Menge::And[1, Menge::Or[2, 3]]].contained?(Menge::Set[2, 3])).to be_truthy }
    it { expect(Menge::Or[1, Menge::And[2, 3]].contained?(Menge::Set[1, 2])).to be_truthy }
    it { expect(Menge::Or[1, Menge::And[2, 3]].contained?(Menge::Set[2, 3])).to be_truthy }
    it { expect(Menge::Or[1, Menge::And[2, 3]].contained?(Menge::Set[3, 4])).to eq false }
    it { expect(Menge::Or[1, Menge::And[2, 3]].contained?(Menge::Set[1])).to be_truthy }
    it { expect(Menge::Not[Menge::Or[1, Menge::And[2, 3]]].contained?(Menge::Set[1])).to eq false }
  end

  context 'deeply nested set' do
    it do
      expect(Menge::And[1, Menge::Not[Menge::And[2, 3], Menge::Or[4, Menge::And[5, 7]]]].contained?(Menge::Set[1, 2, 5]))
      .to be_truthy
    end

    it do
      expect(Menge::And[1, Menge::Not[Menge::And[2, 3], Menge::Or[4, Menge::And[5, 7]]]].contained?(Menge::Set[1, 2, 3, 5]))
      .to be_truthy
    end

    it do
      expect(Menge::And[1, Menge::Not[Menge::And[2, 3], Menge::Or[4, Menge::And[5, 7]]]].contained?(Menge::Set[1, 2, 4]))
      .to be_truthy
    end
  end
end
