class Journey

attr_accessor :exit_station, :journey, :entry_station, :current_journey, :journey_history

MAXIMUM_FARE = 6
MINIMUM_FARE = 1

    def initialize(entry_station)
        @entry_station = entry_station
        @exit_station = nil
    end

    def finish(exit_station)
        @exit_station = exit_station
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