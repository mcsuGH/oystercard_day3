class Journey

attr_accessor :exit_station, :journey, :entry_station, :current_journey, :journey_history

    def initialize(entry_station)
        @current_journey = {entry_station: nil, exit_station: nil}
        @entry_station = entry_station
        @exit_station = nil
        @journey_history = []
        @current_journey[:entry_station] = entry_station
    end

    def end_journey(exit_station)
        @exit_station = exit_station
        @current_journey[:exit_station] = exit_station
        @journey_history.push(@current_journey)
    end

    def in_journey?
        if @entry_station != nil
          return true
        end
    end


end