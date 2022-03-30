require_relative '../lib/journey.rb'

describe Journey do
    let(:entry_station) { double :entry_station}
    let(:journey) { Journey.new(entry_station)}
    let(:exit_station) { double :exit_station }

    it "should remember the entry station after touch in" do
        journey = Journey.new(entry_station)
        journey.entry_station
        expect(journey.entry_station).to eq entry_station
    end
    it "Should deduct a max limit fare if user touches in but doesn't touch out " do
        expect(journey.fare).to eq Journey::MAXIMUM_FARE
    end
    it "Should deduct a minimum fare of 1 if user touches in and touches out" do
        journey.end_journey(exit_station)
        expect(journey.fare).to eq 1
    end
    it "returns itself when exiting a journey" do
        expect(journey.end_journey(exit_station)).to eq(journey)
    end
    it "knows if a journey is complete" do
        journey.end_journey(exit_station)
        expect(journey.complete?).to eq true
    end
end