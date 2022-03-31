require_relative 'station'

class Journey

attr_reader :exit_station, :entry_station

MAXIMUM_FARE = 6
MINIMUM_FARE = 1

    def initialize(station = Station.new(nil,nil))
        @entry_station = station
        @exit_station = nil
        @entry_zone = entry_station.zone
    end

    def finish(station = Station.new(nil,nil))
        @exit_station = station
        @exit_zone = exit_station.zone
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

    private

    def zones_passed
      (@exit_zone - @entry_zone).abs
    end
end 
