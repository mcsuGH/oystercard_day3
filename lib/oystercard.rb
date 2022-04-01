require_relative  'station'
require_relative  'journeylog'
require_relative  'journey'

class Oystercard

MAX_BALANCE = 90
MIN_BALANCE = 1
  
attr_reader :balance, :journeylog
  
  def initialize(journeylog = JourneyLog.new(journey_class: Journey))
    @balance = 0
    @journeylog = journeylog
  end
  
  def top_up(money)
    fail "Maximum balance exceeded" if money + balance > MAX_BALANCE
    @balance += money
  end
  
  def touch_in(station)
    fail "There are insufficient funds" if balance < MIN_BALANCE
    fail "You have already touched in" if in_journey? == true
    @journeylog.start_journey(station)
  end
  
  def touch_out(station)
    fail "You have not touched in at a station" if in_journey? == false
    @journeylog.end_journey(station)
    deduct(@journeylog.cost)
  end
  
  def no_touch_out
    @journeylog.no_touch_out
    deduct(@journeylog.cost)
  end
  
  private 
  
  def deduct(money)
    @balance -= money
  end
  
  def in_journey?
    @journeylog.current_journey[:entry_station] == nil ? false : true
  end
end

