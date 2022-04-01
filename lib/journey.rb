require_relative 'station'

class Journey

attr_reader :exit_station, :entry_station

MAXIMUM_FARE = 6
MINIMUM_FARE = 1

    def initialize(station)
        @entry_station = station
        @exit_station = nil
        @entry_zone = entry_station.zone
    end

    def finish(station)
        @exit_station = station
        @exit_zone = exit_station.zone
        @entry_station = nil
        self
    end

    def complete?
        @entry_station == nil ? true : false
    end

    def fare
      complete? ? MINIMUM_FARE + zones_passed : MAXIMUM_FARE
    end

    private

    def zones_passed
      (@exit_zone - @entry_zone).abs
    end
end 
