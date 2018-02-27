BALANCE_LIMIT = 90

class Oystercard
  attr_reader :balance
  def initialize
    @balance = 0
    @travel_status = false
  end

  def top_up(amount)
    fail 'Balance limit is 90' if exceeded?(amount)
    @balance += amount
  end

  def exceeded?(amount)
    @balance + amount > BALANCE_LIMIT
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @travel_status == true
  end

  def touch_in
    fail "Insufficient funds!" unless balance > 1
    @travel_status = true
  end

  def touch_out
    @travel_status = false
  end
end
