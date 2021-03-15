require 'Oyster_Card'

describe OysterCard do
  it 'shows the balance' do
    expect(subject.balance).to eq(0)
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
    it 'can remove money from balance' do
      subject.top_up(40)
      subject.deduct(30)
      expect(subject.balance).to eq(10)
      # expect { subject.deduct(30) }.to change {subject.balance }.to(10)
    end
  end

  describe 'in_journey?' do
    it 'initially, individual is not in journey' do
      expect(subject).not_to be_in_journey
    end

    it 'can tap in to be in journey' do
      subject.touch_in
      expect(subject).to be_in_journey
    end
    

    # it 'can touch oyster card in' do

    # end 
  end
end