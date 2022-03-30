require 'journeylog'

describe JourneyLog do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }
  let(:subject) { JourneyLog.new(journey_class: Journey.new(nil)) }

  it 'start a journey' do
    subject.start_journey(entry_station)
    expect(subject.current_journey[:entry_station]).to eq entry_station
  end

  it 'should end a journey' do
    subject.start_journey(entry_station)
    subject.end_journey(exit_station)
    expect(subject.history[0][:exit_station]).to eq exit_station
  end

  it 'should record a list of journey history' do
    subject.start_journey(entry_station)
    subject.end_journey(exit_station)
    expect(subject.history).to include(journey)
  end
end