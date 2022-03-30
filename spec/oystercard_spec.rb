require_relative '../lib/oystercard.rb'

describe Oystercard do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_Station } 
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

  it "shows user's balance"  do
    expect(subject.balance).to eq 0
  end
  it "adds money to the balance" do
    expect(subject.top_up(50)).to eq 50
  end
  it "warn if top up is over the maximum balance" do
    expect{subject.top_up(100)}.to raise_error "Maximum balance exceeded"
  end
  it "will not touch in if below minimum balance" do 
    expect{subject.touch_in("Bank Station")}.to raise_error "There are insufficient funds"
  end
  it "can touch in" do 
    subject.top_up(1)
    journey = Journey.new("Bank Station")
    subject.touch_in("Bank Station")
    expect(journey.entry_station).to include("Bank Station")
  end
  it "can touch out" do
    subject.top_up(1)
    subject.touch_in("Bank Station")
    subject.touch_out("Westminster")
    expect(subject.journeylog.journey_history.count).to eq(1)
  end
  it "should raise an error if the maximum balance is exceeded" do
    maximum_balance = Oystercard::MAX_BALANCE
    subject.top_up(maximum_balance)
    expect{subject.top_up(1)}.to raise_error "Maximum balance exceeded"
  end
  it "should deduct money from balance when touching out" do
    subject.top_up(1)
    subject.touch_in("Bank Station")
    expect{subject.touch_out("Westminster")}.to change{subject.balance}.by(-Oystercard::MIN_BALANCE)
  end
  # it "should remember the entry station after touch in" do
  #   subject.top_up(1)
  #   expect(subject.touch_in("Bank Station")).to eq "Bank Station"
  # end
  it "should have an empty journey history by default" do
    expect(subject.journeylog.journey_history).to eq []
  end
  it "should create one journey when touching in then touching out" do
    subject.top_up(1)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeylog.journey_history[0]).to include(journey)
  end
end