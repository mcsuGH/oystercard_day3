class JourneyLog

attr_reader :cost

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @current_journey = {entry_station: nil, exit_station: nil}
    @journey_history = []
  end

  def start_journey(station)
    @current_journey[:exit_station] = nil
    @current_journey[:entry_station] = station
    @journey_class = Journey.new(station)
  end

  def end_journey(station)
    @current_journey[:exit_station] = station
    @journey_class.finish(station)
    record_journey
    cost
  end

  def no_touch_out
    record_journey
    cost
  end

  def cost
    @cost = @journey_class.fare
  end

  def history
    @journey_history.dup
  end

  def current_journey
    @current_journey ||= @journey_class = Journey.new
  end

  private 

  def record_journey
    @journey_history.push({entry_station: @current_journey[:entry_station], exit_station: @current_journey[:exit_station]} )
    @current_journey = {entry_station: nil, exit_station: nil}
  end
end