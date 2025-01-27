require 'oystercard'

describe "A new card" do
  it 'create a card, top up, and use it to travel between stations' do
    card = Oystercard.new
    st1 = Station.new("test",1)
    st2 = Station.new("test",4)
    card.top_up(50)
    card.touch_in(st1)
    expect {card.touch_out(st2)}.to change { card.balance }.by(-4)
  end
end