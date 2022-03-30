require_relative 'journey'

class Oystercard

MAX_BALANCE = 90
MIN_BALANCE = 1

attr_reader :balance, :journey_history, :journey
attr_accessor :entry_station, :exit_station, :current_journey

  def initialize
    @balance = 0
    @journey = Journey.new(nil)
  end

  def top_up(money)
    fail "Maximum balance exceeded" if money + balance > MAX_BALANCE
    @balance += money
  end

  def touch_in(entry_station)
    fail "There are insufficient funds" if balance < MIN_BALANCE
    @journey = Journey.new(entry_station)
    #@entry_station = entry_station
  end

  def touch_out(exit_station)
    @journey.end_journey(exit_station)
    deduct(MIN_BALANCE)
  end


  private 

  def deduct(money)
    @balance -= money
  end
end

