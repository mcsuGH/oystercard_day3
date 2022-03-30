class Journey

attr_accessor :exit_station, :journey, :entry_station, :current_journey, :journey_history

MAXIMUM_FARE = 6
MINIMUM_FARE = 1

    def initialize(entry_station)
        record_journey(entry_station)
        @exit_station = nil
        @journey_history = []
    end

    def record_journey(entry_station)
        @entry_station = entry_station
        @current_journey = {entry_station: nil, exit_station: nil}
        @current_journey[:entry_station] = entry_station
    end

    def end_journey(exit_station)
        @exit_station = exit_station
        @current_journey[:exit_station] = exit_station
        @journey_history.push(@current_journey)
        @entry_station = nil
        self
    end

    def complete?
        if @entry_station == nil
          return true
        else
            false
        end
    end

    def fare
    complete? ? MINIMUM_FARE : MAXIMUM_FARE
    end
end