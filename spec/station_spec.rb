require 'station'

describe Station do
  subject(:station){Station.new}
  before(:each) do
    @station = (Station.new(:cat, :dog))
  end

  describe '#initialize' do
    it "sets zone upon creation" do
      expect(@station.zone).to eq :dog
    end

    it "sets name upon creation" do
      expect(@station.name).to eq :cat
    end
  end
end
