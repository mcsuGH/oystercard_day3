require_relative '../lib/oystercard.rb'

describe Oystercard do
  let(:entry_station) { double "entry_station", name: "entry_station", zone: 1 }
  let(:exit_station) { double "exit_station", name: "exit_station", zone: 1 }
  let(:journey_log) { double "journey_log", history: [] }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }
  let(:subject) { Oystercard.new(journey_log) }

  it "shows user's balance"  do
    expect(subject.balance).to eq 0
  end

  describe "#topup" do
    it "adds money to the balance" do
      expect(subject.top_up(50)).to eq 50
    end

    it "warn if top up is over the maximum balance" do
      expect{subject.top_up(100)}.to raise_error "Maximum balance exceeded"
    end

    it "should raise an error if the maximum balance is exceeded" do
      subject.top_up(Oystercard::MAX_BALANCE)
      expect{subject.top_up(1)}.to raise_error "Maximum balance exceeded"
    end
  end

  describe "#touch_in" do
    it "will not touch in if below minimum balance" do 
      expect{subject.touch_in(entry_station)}.to raise_error "There are insufficient funds"
    end

    it "should remember the entry station after touch in" do 
      subject.top_up(1)
      allow(subject).to receive(:in_journey?).and_return(false)
      allow(journey_log).to receive(:start_journey)
      subject.touch_in(entry_station)
      allow(journey_log).to receive(:current_journey).and_return([entry_station])
      expect(subject.journeylog.current_journey).to include(entry_station)
    end
  end 

  describe "#touch_out" do
    it "can touch out" do
      subject.top_up(1)
      allow(subject).to receive(:in_journey?).and_return(false)
      allow(journey_log).to receive(:start_journey)
      subject.touch_in(entry_station)
      allow(subject).to receive(:in_journey?).and_return(true)
      allow(journey_log).to receive(:end_journey)
      allow(journey_log).to receive(:cost).and_return(1)
      subject.touch_out(exit_station)
      allow(journey_log).to receive(:history).and_return([journey])
      expect(subject.journeylog.history.count).to eq(1)
    end

    it "should deduct money from balance when touching out" do
      subject.top_up(1)
      allow(subject).to receive(:in_journey?).and_return(false)
      allow(journey_log).to receive(:start_journey)
      subject.touch_in(entry_station)
      allow(subject).to receive(:in_journey?).and_return(true)
      allow(journey_log).to receive(:end_journey)
      allow(journey_log).to receive(:cost).and_return(1)
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::MIN_BALANCE)
    end

    it 'will raise an error if you touch out before touching in' do
      allow(subject).to receive(:in_journey?).and_return(false)
      expect { subject.touch_out(exit_station) }.to raise_error "You have not touched in at a station"
    end
  end

  it "should have an empty journey history by default" do
    expect(subject.journeylog.history).to eq []
  end

  it "should create one journey when touching in then touching out" do
    subject.top_up(1)
    allow(subject).to receive(:in_journey?).and_return(false)
    allow(journey_log).to receive(:start_journey)
    subject.touch_in(entry_station)
    allow(subject).to receive(:in_journey?).and_return(true)
    allow(journey_log).to receive(:end_journey)
    allow(journey_log).to receive(:cost).and_return(1)
    subject.touch_out(exit_station)
    allow(journey_log).to receive(:history).and_return(journey)
    expect(subject.journeylog.history).to include(journey)
  end
end