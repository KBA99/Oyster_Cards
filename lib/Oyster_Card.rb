
class OysterCard
  attr_accessor :balance

  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
  end

  def in_journey?
    false
  end

  def touch_in
    # in_journey? == true
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end
