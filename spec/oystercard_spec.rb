require 'oystercard'

describe Oystercard do
  before(:each) do
    @station = double(:station)
  end
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

  #describe '#deduct' do
  #   it { is_expected.to respond_to(:deduct).with(1).argument}
  #
  #   it 'deducts fare from balance' do
  #     oystercard = Oystercard.new
  #     oystercard.top_up(10)
  #     oystercard.deduct(5)
  #     expect(oystercard.balance).to eq 5
  #   end
  # end

  describe '#in_journey' do
    it 'checks that a new card is not in use' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'checks that a card is in use after touching in' do
      oystercard = Oystercard.new
      oystercard.top_up(5)
      oystercard.touch_in(@station)
      expect(oystercard.in_journey?).to eq true
    end

    it 'should be able to record entry station upon touching in' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in(@station)
      expect(card.entry).to eq @station
    end
  end

  describe '#touch_out' do
    it 'checks that a card in no longer in use after touching out' do
      oystercard = Oystercard.new
      oystercard.top_up(5)
      oystercard.touch_in(@station)
      oystercard.touch_out
      expect(oystercard).not_to be_in_journey
    end

    it 'raises error when trying to touch in with balance less than 1' do
      expect { subject.touch_in(@station) }.to raise_error "Insufficient funds!"
    end

    it 'deducts minimum fare upon touch out' do
      subject.top_up(5)
      subject.touch_in(@station)
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end
end
