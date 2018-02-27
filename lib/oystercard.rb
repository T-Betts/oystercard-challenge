class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 2
  MINIMUM_BALANCE = 1
  attr_reader :balance
  attr_accessor :entry
  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail 'Balance limit is 90' if exceeded?(amount)
    @balance += amount
  end

  def exceeded?(amount)
    @balance + amount > BALANCE_LIMIT
  end

  def in_journey?
    @entry != nil
  end

  def touch_in(station)
    fail "Insufficient funds!" unless balance > MINIMUM_BALANCE
    @entry = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry = nil
  end

  private
  def deduct(fare)
    @balance -= fare
  end
end
