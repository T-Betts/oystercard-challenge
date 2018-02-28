class Journey
  def initialize
    @jounrey = {}
  end

  def start(station)
    @entry_station = station
    @journey[@entry_station] = nil
  end

  def end(station)
    @exit_station = station
    @journey[@entry_station] = @exit_station
  end
  #all touch outs are valid and after touching out the journey should be pushed
  #to the card's journey_history array. if touch_in is called twice in a row you
  #should set the exit station to nil, push the invalid journey to the journey_history,
  #and charge the card a penalty. make sure you delegate from oystercard and ensure only
  #journey_history and penalty fares are handled in the journey section of Oystercard
end
