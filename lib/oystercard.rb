require_relative 'journey'
require_relative 'journeylog'
require_relative 'station'

class Oystercard

MAX_BALANCE = 90
MIN_BALANCE = 1

attr_reader :balance, :journeylog

  def initialize
    @balance = 0
    @journeylog = JourneyLog.new(journey_class: Journey)
  end

  def top_up(money)
    fail "Maximum balance exceeded" if money + balance > MAX_BALANCE
    @balance += money
  end

  def touch_in(entry_station)
    fail "There are insufficient funds" if balance < MIN_BALANCE
    @journeylog.start_journey(entry_station)
  end

  def touch_out(exit_station)
    @journeylog.end_journey(exit_station)
    deduct(MIN_BALANCE)
  end

  private 

  def deduct(money)
    @balance -= money
  end
end

