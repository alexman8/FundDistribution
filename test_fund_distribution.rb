require_relative 'fund_distribution'
require 'test/unit'

class TestFundDistribution < Test::Unit::TestCase
  def setup
    @participants = [ # total funding owed is 26
      Participant.new('d', 9),
      Participant.new('b', 2),
      Participant.new('a', 11),
      Participant.new('c', 4)
    ]
  end

  def test_more_than_enough_funding
    funding = 50
    distributions = {'d' => 9, 'b' => 2, 'a' => 11, 'c' => 4}
    assert_equal distributions, distribute_fund(@participants, funding), 'All participants should be paid in full'
  end

  def test_just_enough_funding
    funding = 26
    distributions = {'d' => 9, 'b' => 2, 'a' => 11, 'c' => 4}
    assert_equal distributions, distribute_fund(@participants, funding), 'All participants should be paid in full'
  end

  def test_not_enough_funding_one
    funding = 25
    distributions = {'d' => 9, 'b' => 2, 'a' => 10, 'c' => 4}
    assert_equal distributions, distribute_fund(@participants, funding), 'Participants with higher amount owed will have the remaining fund distributed to them as even as possible with priority given to the participants having names that have lower alphabetical sort order'
  end

  def test_not_enough_funding_two
    funding = 16
    distributions = {'d' => 5, 'b' => 2, 'a' => 5, 'c' => 4}

    assert_equal distributions, distribute_fund(@participants, funding), 'Participants with higher amount owed will have the remaining fund distributed to them as even as possible with priority given to the participants having names that have lower alphabetical sort order'
  end

  def test_some_do_not_get_paid
    funding = 3
    distributions = {'d' => 0, 'b' => 1, 'a' => 1, 'c' => 1}

    assert_equal distributions, distribute_fund(@participants, funding), 'Priority given to the participants having names that have lower alphabetical sort order'
  end

  def test_no_participants
    funding = 50
    no_participants = []
    distributions = {}
    assert_equal distributions, distribute_fund(no_participants, funding), 'Should return an empty distribution hash'
  end

  def test_no_funding
    funding = 0
    distributions = {'d' => 0, 'b' => 0, 'a' => 0, 'c' => 0}
    assert_equal distributions, distribute_fund(@participants, funding), 'No participant is paid anything'
  end
end