class Journey

attr_accessor :exit_station, :journey, :entry_station

    def initialize(entry_station)
        @entry_station = entry_station
        @exit_station = nil
        @journey = {"Entry station" => @entry_station}
    end

    def end_journey(exit_station)
        @exit_station = exit_station
        @journey["Exit station"] = @exit_station
        
    end

    def in_journey?
        if @entry_station != nil
          return true
        end
    end


end