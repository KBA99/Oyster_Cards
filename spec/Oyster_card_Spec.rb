require 'Oyster_Card'

describe OysterCard do
  let(:station) {double :station}

  it 'shows the balance' do
    expect(subject.balance).to eq(0)
  end

  it 'responds to entry station' do
    expect(subject).to respond_to(:entry_station)
  end

  describe '#top_up' do
    it 'can add money to balance' do
      oyster_card = subject
      oyster_card.top_up(10)
      expect(oyster_card.balance).to eq(10)
    end

    it 'raises an error if the top up is greater than maximum balance' do
      maximum_balance = OysterCard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end
  end

  describe '#deduct' do
    # it 'can remove money from balance' do
    #   subject.top_up(40)
    #   subject.deduct(30)
    #   expect(subject.balance).to eq(10)
    #   # expect { subject.deduct(30) }.to change { subject.balance }.to(10)
    # end

    it 'charges you after journey' do 
      subject.top_up(OysterCard::MAXIMUM_BALANCE)
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by(-OysterCard::MINIMUM_CHARGE)
    end
  end

  describe 'in_journey?' do
    it 'initially, individual is not in journey' do
      expect(subject).not_to be_in_journey
    end

    it 'can tap in to be in journey' do
      subject.top_up(OysterCard::MAXIMUM_BALANCE)
      subject.touch_in
      expect(subject.in_journey?).to be(true)
    end

    # it 'allows you to touch in with a station' do
    #   expect(subject.touch_in(station)).to eq(station)
    # end
    
    it 'can tap out to be out of journey' do 
      subject.top_up(OysterCard::MAXIMUM_BALANCE)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to be(false)
    end

    describe 'Travelleing with minimum balance' do 
      it 'will not touch in if below minimum balance' do
        oyster_card = subject
        oyster_card.balance = 0
        expect{ subject.touch_in }.to raise_error "Insufficient balance to touch in"
      end
    end
  end
end