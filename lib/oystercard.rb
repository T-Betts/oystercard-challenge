BALANCE_LIMIT = 90

class Oystercard
  attr_reader :balance
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
end
