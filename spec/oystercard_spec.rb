require_relative '../lib/oystercard.rb'

describe Oystercard do
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
    expect{subject.touch_in}.to raise_error "There are insufficient funds"
  end
  it "can touch in" do 
    subject.top_up(1)
    subject.touch_in
    expect(subject).to be_in_journey
  end
  it "can touch out" do
    subject.top_up(1)
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end
  it "should raise an error if the maximum balance is exceeded" do
    maximum_balance = Oystercard::MAX_BALANCE
    subject.top_up(maximum_balance)
    expect{subject.top_up(1)}.to raise_error "Maximum balance exceeded"
  end
  it "should deduct money from balance when touching out" do
    subject.top_up(1)
    subject.touch_in
    expect{subject.touch_out}.to change{subject.balance}.by(-Oystercard::MIN_BALANCE)
  end
end