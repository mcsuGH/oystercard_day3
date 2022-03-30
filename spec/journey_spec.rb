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
        journey.finish(exit_station)
        expect(journey.fare).to eq 1
    end
    it "returns itself when exiting a journey" do
        expect(journey.finish(exit_station)).to eq(journey)
    end
    it "knows if a journey is complete" do
        journey.finish(exit_station)
        expect(journey.complete?).to eq true
    end
    it "charges an additional 1 when 1 zone is passed" do
        expect(journey.fare).to eq 2
    end
    it "charges an additional 2 when 2 zones are passed" do
        expect(journey.fare).to eq 3
    end
    it "charges an additional 3 when 3 zones are passed" do
        expect(journey.fare).to eq 4
    end
    it "charges an additional 4 when 4 zones are passed" do
        expect(journey.fare).to eq 5
    end
    it "charges an additional 5 when 5 zones are passed" do
        expect(journey.fare).to eq 6
    end
    it "charges the minimum fare when no zones are passed" do
        expect(journey.fare).to eq MINIMUM_FARE
    end
end