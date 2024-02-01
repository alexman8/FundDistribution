class Participant
  attr_accessor :name, :amount_owed, :amount_received

  def initialize(name, amount_owed)
    @name            = name
    @amount_owed     = amount_owed
    @amount_received = 0
  end

  def receive(money)
    @amount_received += money
  end

  def remaining_balance
    @amount_owed - @amount_received
  end

  def creditor?
    @amount_received < @amount_owed
  end

  def paid_in_full?
    @amount_received == @amount_owed
  end
end

# @param participants [Array<Participant>]
# @param funding [Integer]
# @return [Hash] the distributions to the participants
def distribute_fund(participants, funding)
  loop do
    break if funding == 0 || participants.all?(&:paid_in_full?)

    participants_to_pay = participants.select(&:creditor?)

    if funding < participants_to_pay.size
      participants_to_pay = participants_to_pay.sort_by(&:name)

      for i in 0...funding do
        participants_to_pay[i].receive(1)
        funding -= 1
      end
    else
      distributing_amount = funding / participants_to_pay.size

      participants_to_pay.each do |participant_to_pay|
        actual_payment = [distributing_amount, participant_to_pay.remaining_balance].min
        participant_to_pay.receive(actual_payment)
        funding -= actual_payment
      end
    end
  end

  {}.tap do |distributions|
    participants.each do |participant|
      distributions[participant.name] = participant.amount_received
    end
  end
end
