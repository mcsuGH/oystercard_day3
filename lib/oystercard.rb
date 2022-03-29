class Oystercard

MAX_BALANCE = 90
MIN_BALANCE = 1

attr_reader :balance, :entry_station

  def initialize
  @balance = 0
  @entry_station = nil
  end

  def top_up(money)
    fail "Maximum balance exceeded" if money + balance > MAX_BALANCE
    @balance += money
  end

  def touch_in(entry_station)
    fail "There are insufficient funds" if balance < MIN_BALANCE
    @entry_station = entry_station  
  end

  def touch_out
    deduct(MIN_BALANCE)
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

