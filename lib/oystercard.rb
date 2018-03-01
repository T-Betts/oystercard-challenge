require_relative './journey.rb'

class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 5
  attr_reader :balance, :journey_history, :journey

  def initialize(journey = Journey.new)
    @balance = 0
    @journey_history = []
    @journey = journey
  end

  def top_up(amount)
    fail 'Balance limit is 90' if exceeded?(amount)
    @balance += amount
  end

  def exceeded?(amount)
    @balance + amount > BALANCE_LIMIT
  end

  def in_journey?
    @journey.entry_station != nil
  end

  def touch_in(station)
    fail "Insufficient funds!" unless balance >= MINIMUM_FARE
    if !@journey.journey.keys.empty?
      penalty_charge
    end
    @journey.start(station)
  end

  def penalty_charge
    deduct(PENALTY_FARE)
    add_to_journey_history(@journey.finish(nil))
    @journey.journey = {}
    p "£5 penalty charge for not touching out of previous journey"
  end

  def add_to_journey_history(journey)
    @journey_history << journey
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    add_to_journey_history(@journey.finish(station))
    @journey.journey={}
  end

  private
  def deduct(fare)
    @balance -= fare
  end
end
