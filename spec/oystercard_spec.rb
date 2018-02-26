require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'returns a balance of 0 on a new card' do
      oystercard = Oystercard.new
      expect(oystercard.balance).to eq 0
    end
  end
end
