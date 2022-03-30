require_relative 'station'

class Journey

attr_accessor :exit_station, :journey, :entry_station, :current_journey, :journey_history

MAXIMUM_FARE = 6
MINIMUM_FARE = 1


    def initialize(station: Station)
        @entry_station = station
        @exit_station = nil
        @entry_zone = @entry_station.zone
    end

    def finish(station: Station)
        @exit_zone = @exit_station.zone
        @exit_station = station
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
      complete? ? MINIMUM_FARE + zones_passed : MAXIMUM_FARE
    end

    def zones_passed
        (@exit_zone - @entry_zone).abs
    end
end