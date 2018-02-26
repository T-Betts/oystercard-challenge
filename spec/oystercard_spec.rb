require 'oystercard'

describe Oystercard do
  describe '#balance' do
    it 'returns a balance of 0 on a new card' do
      oystercard = Oystercard.new
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'checks that top_up increases balance by 10' do
      oystercard = Oystercard.new
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end
  end 
end
