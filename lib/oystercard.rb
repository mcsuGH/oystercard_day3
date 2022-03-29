class Oystercard

MAX_BALANCE = 90
MIN_BALANCE = 1

attr_reader :balance, :entry_station, :journey_history

  def initialize
  @balance = 0
  @entry_station = nil
  @exit_station = nil
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
    @entry_station != nil

  end

  private 

  def deduct(money)
    @balance -= money
  end
end

