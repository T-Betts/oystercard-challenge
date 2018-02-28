class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance
  attr_accessor :entry_station, :exit_station
  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    fail 'Balance limit is 90' if exceeded?(amount)
    @balance += amount
  end

  def exceeded?(amount)
    @balance + amount > BALANCE_LIMIT
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    fail "Insufficient funds!" unless balance >= MINIMUM_FARE
    @entry_station = station
  end

  def add_to_journey_history

  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    @journey_history << {@entry_station => @exit_station}
    @entry_station = nil
  end

  def journey_history
    @journey_history
  end

  private
  def deduct(fare)
    @balance -= fare
  end
end
