class Oystercard

MAX_BALANCE = 90
MIN_BALANCE = 1

attr_reader :balance

  def initialize
  @balance = 0
  end

  def top_up(money)
    fail "Maximum balance exceeded" if money + balance > MAX_BALANCE
    @balance += money
  end

  def touch_in
    fail "There are insufficient funds" if balance < MIN_BALANCE
    @in_journey = true
  end

  def touch_out
    deduct(MIN_BALANCE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private 

  def deduct(money)
    @balance -= money
  end
end

