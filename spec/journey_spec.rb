require 'journey'

describe Journey do
  subject(:journey){Journey.new}
  let(:station){double(:station)}
  let(:station_2){double(:station_2)}

  describe '#start' do
    it "sets an entry station" do
      subject.start(station)
      expect(subject.entry_station).to eq station
    end

    it "places entry station inside @journey as a hash key" do
      subject.start(station)
      expect(subject.journey).to eq({station => nil})
    end
  end

  describe '#finish' do
    it "sets an exit station" do
      subject.start(station)
      subject.finish(station_2)
      expect(subject.exit_station).to eq station_2
    end

    it 'sets exit_station as a value for entry_station in @journey hash' do
      subject.start(station)
      subject.finish(station_2)
      expect(subject.journey).to eq({station => station_2})
    end
  end
end
