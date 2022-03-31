require_relative '../lib/journey.rb'

describe Journey do
    let(:entry_station) { double "entry_station", :name => "entry_station", :zone=>1 }
    let(:exit_station) { double "exit_station", :name => "exit_station", :zone=>1 }
    let(:journey) { Journey.new(entry_station)}

    it "should remember the entry station after touch in" do
        journey.entry_station
        expect(journey.entry_station).to eq entry_station
    end

    it "Should deduct a max limit fare if user touches in but doesn't touch out " do
        expect(journey.fare).to eq Journey::MAXIMUM_FARE
    end

    it "Should deduct a minimum fare of 1 if user touches in and touches out" do
        journey.finish(entry_station)
        expect(journey.fare).to eq 1
    end

    it "returns itself when exiting a journey" do
        expect(journey.finish(exit_station)).to eq(journey)
    end

    it "knows if a journey is complete" do
        journey.finish(exit_station)
        expect(journey.complete?).to eq true
    end

    describe "#fare" do
    let(:exit_station1) { double "exit_station", :name => "exit_station1", :zone =>2 }
    let(:exit_station2) { double "exit_station", :name => "exit_station2", :zone =>3 }
    let(:exit_station3) { double "exit_station", :name => "exit_station3", :zone =>4 }
    let(:exit_station4) { double "exit_station", :name => "exit_station4", :zone =>5 }
    let(:exit_station5) { double "exit_station", :name => "exit_station5", :zone =>6 }

      it "charges an additional 1 when 1 zone is passed" do
        journey.finish(exit_station1)
        expect(journey.fare).to eq 2
      end

      it "charges an additional 2 when 2 zones are passed" do
        journey.finish(exit_station2)
        expect(journey.fare).to eq 3
      end

      it "charges an additional 3 when 3 zones are passed" do
        journey.finish(exit_station3)
        expect(journey.fare).to eq 4
      end

      it "charges an additional 4 when 4 zones are passed" do
        journey.finish(exit_station4)
        expect(journey.fare).to eq 5
      end

      it "charges an additional 5 when 5 zones are passed" do
        journey.finish(exit_station5)
        expect(journey.fare).to eq 6
      end

      it "charges the minimum fare when no zones are passed" do
        journey.finish(exit_station)
        expect(journey.fare).to eq Journey::MINIMUM_FARE
      end
    end
end