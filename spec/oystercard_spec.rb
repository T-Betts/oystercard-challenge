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
  end

  describe '#in_journey' do
    it 'checks that a new card is not in use' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'checks that a card is in use after touching in' do
      oystercard = Oystercard.new
      oystercard.top_up(5)
      oystercard.touch_in
      expect(oystercard.in_journey?).to eq true
    end
  end

  describe '#touch_out' do
    it 'checks that a card in no longer in use after touching out' do
      oystercard = Oystercard.new
      oystercard.top_up(5)
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it 'deducts minimum fare upon touch out' do
      subject.top_up(5)
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end
end
