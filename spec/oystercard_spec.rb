require 'oystercard'

describe Oystercard do
  before(:each) do
    @entry_station = double(:entry_station)
    @exit_station = double(:exit_station)
    @touched_in_card = Oystercard.new
    @touched_in_card.top_up(Oystercard::MINIMUM_FARE)
    @touched_in_card.touch_in(@entry_station)
  end
  context 'new card' do
    it 'has a default balance of 0' do
      oystercard = Oystercard.new
      expect(oystercard.balance).to eq 0
    end

    it "has an empty journey history list by default" do
      expect(subject.journey_history).to be_empty
    end
  end

  describe '#top_up' do
    it 'checks that top_up increases balance by 10' do
      oystercard = Oystercard.new
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end

    it 'raises an error if top up limit is exceeded' do
      expect { subject.top_up(91) }.to raise_error 'Balance limit is 90'
    end
  end

  describe '#in_journey' do
    it 'checks that a new card is not in use' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'checks that a card is in use after touching in' do
      expect(@touched_in_card.in_journey?).to eq true
    end

    it 'records entry station upon touching in' do
      expect(@touched_in_card.journey.entry_station).to eq @entry_station
    end

    it 'charge penalty fare if card owner failed to touch out of previous journey' do
      subject.top_up(10)
      subject.touch_in(@entry_station)
      expect{ subject.touch_in(@entry_station) }.to change { subject.balance }.by(-Oystercard::PENALTY_FARE)
    end
  end

  describe '#touch_out' do
    it 'checks that a card in no longer in use after touching out' do
      @touched_in_card.touch_out(@exit_station)
      expect(@touched_in_card).not_to be_in_journey
    end

    it 'raises error when trying to touch in with balance less than 1' do
      expect { subject.touch_in(@entry_station) }.to raise_error "Insufficient funds!"
    end

    it 'deducts minimum fare upon touch out' do
      expect { @touched_in_card.touch_out(@exit_station) }.to change { @touched_in_card.balance }.by(-Oystercard::MINIMUM_FARE)
    end

    it 'records exit station upon touching out' do
      @touched_in_card.touch_out(@exit_station)
      expect(@touched_in_card.journey.exit_station).to eq @exit_station
    end

    let(:journey){ {@entry_station => @exit_station} }
    it 'records a journey in journey_history upon touching out' do
      card = Oystercard.new
      card.top_up(5)
      card.touch_in(@entry_station)
      card.touch_out(@exit_station)
      expect(card.journey_history).to include journey
    end
  end
end
