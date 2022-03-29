require 'station'

describe Station do 
  let(:station) { Station.new }

  it "is initialized with a name" do 
    station = Station.new("Bank", 4)
    expect(station.name).to include "Bank"
  end
  it "is initialized with a zone" do
    station = Station.new("Bank", 4)
    expect(station.zone).to eq 4
  end
end