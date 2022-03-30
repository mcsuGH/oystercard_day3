require_relative 'journey'

class JourneyLog
  attr_reader :current_journey

  def initialize(journey_class: Journey.new(nil))
    @journey_class = journey_class
    @current_journey = {entry_station: nil, exit_station: nil}
    @journey_history = []
  end

  def start_journey(entry_station)
    @current_journey[:exit_station] = nil
    @current_journey[:entry_station] = entry_station
    @journey_class = Journey.new(entry_station)
  end

  def end_journey(exit_station)
    @current_journey[:exit_station] = exit_station
    @journey_history.push(@current_journey)
    @journey_class.finish(exit_station)
    @current_journey = {entry_station: nil, exit_station: nil}
  end

  def history
    @journey_history.dup
  end

  private 

  def current
    if @current_journey[:exit_station] == nil
      @current_journey
    else
      @journey_class = Journey.new(nil)
    end
  end
end