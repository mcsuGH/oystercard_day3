require_relative 'journey'

class Oystercard

MAX_BALANCE = 90
MIN_BALANCE = 1

attr_reader :balance, :journey_history, :journeylog
attr_accessor :entry_station, :exit_station, :current_journey

  def initialize
    @balance = 0
    @journeylog = JourneyLog.new(journey_class: Journey.new(nil))
  end

  def top_up(money)
    fail "Maximum balance exceeded" if money + balance > MAX_BALANCE
    @balance += money
  end

  def touch_in(entry_station)
    fail "There are insufficient funds" if balance < MIN_BALANCE
    @journeylog.start_journey(entry_station)
    #@entry_station = entry_station
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

