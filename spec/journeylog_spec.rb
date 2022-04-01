require 'journeylog'

describe JourneyLog do
  let(:entry_station) { double "entry_station", name: "entry_station", zone: 1 }
  let(:exit_station) { double "exit_station", name: "exit_station", zone: 1 }
  let(:entry_to_exit) { {entry_station: entry_station, exit_station: exit_station} }
  let(:journey_class) { double 'journey_class' }
  let(:journey_double) { double 'journey', entry_station: entry_station }
  let(:subject) { JourneyLog.new(journey_class = journey_class) }

  it 'start a journey' do
    subject.start_journey(entry_station)
    expect(subject.current_journey[:entry_station]).to eq entry_station
  end

  it 'should end a journey' do
    subject.start_journey(entry_station)
    subject.end_journey(exit_station)
    expect(subject.history.last[:exit_station]).to eq exit_station
  end

  it 'should record a list of journey history' do
    subject.start_journey(entry_station)
    subject.end_journey(exit_station)
    expect(subject.history).to include(entry_to_exit)
  end
end