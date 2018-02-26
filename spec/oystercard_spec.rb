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

    it 'raises an error if top up limit is exceeded' do
      oystercard = Oystercard.new
      expect { oystercard.top_up(91) }.to raise_error 'Balance limit is 90'
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument}

    it 'deducts fare from balance' do
      oystercard = Oystercard.new
      oystercard.top_up(10)
      oystercard.deduct(5)
      expect(oystercard.balance).to eq 5
    end

  describe '#in_journey?' do
    it 'shows a new oystercard isn\'t in journey' do
      oystercard = Oystercard.new
      expect(oystercard.in_journey?).to eq false
    end
  end
  end
end
