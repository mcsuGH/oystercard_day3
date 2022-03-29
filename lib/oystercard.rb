class Oystercard

MAX_BALANCE = 90
MIN_BALANCE = 1

attr_reader :balance, :journey_history
attr_accessor :entry_station, :exit_station

  def initialize
  @balance = 0
  @entry_station = entry_station
  @exit_station = exit_station
  @journey_history = []
  end

  def top_up(money)
    fail "Maximum balance exceeded" if money + balance > MAX_BALANCE
    @balance += money
  end

  def touch_in(entry_station)
    fail "There are insufficient funds" if balance < MIN_BALANCE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_BALANCE)
    @exit_station = exit_station
    @entry_station = entry_station
    journey = {"Entry station" => entry_station, "Exit station" => exit_station}
    @journey_history.push(journey)
    @entry_station = nil
  end

  def in_journey?
    if @entry_station != nil
      return true
    end
  end

  private 

  def deduct(money)
    @balance -= money
  end
end

