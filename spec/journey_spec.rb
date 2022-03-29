require_relative '../lib/journey.rb'

describe Journey do
    let(:entry_station) { double :entry_station}
    it "should remember the entry station after touch in" do
        journey = Journey.new(entry_station)
        p journey.entry_station
        expect(journey.entry_station).to eq entry_station
    end
end