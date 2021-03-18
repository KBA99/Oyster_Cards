
class OysterCard
  attr_accessor :balance
  attr_reader :entry_station, :exit_station, :journey_list, :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_CHARGE = 1

  def initialize
    @balance = 0
    @entry_station
    @journey_list = []
    @exit_station
    @journey = {entry_station: entry_station, exit_station: exit_station}
  end

  def in_journey?
    !! entry_station
  end

  def touch_in(station)
    fail "Insufficient balance to touch in" if balance < MINIMUM_CHARGE
    # @entry_station = station
    @journey[:entry_station] = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    entry_station = nil
    # @exit_station = station
    @journey[:exit_station] = station
    @journey_list << @journey
  end

  def top_up(amount)
    fail "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end
  
  private
  def deduct(amount)
    @balance -= amount
  end

end

oyster_card = OysterCard.new
oyster_card.top_up(30)
oyster_card.touch_in("London")
oyster_card.touch_out("Leicester")
puts oyster_card
puts oyster_card.journey
print oyster_card.journey_list