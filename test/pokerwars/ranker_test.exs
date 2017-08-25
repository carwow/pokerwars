defmodule Pokerwars.RankerTest do
  use ExUnit.Case, async: true
  doctest Pokerwars.Ranker

  test "Straight flush beats four of a kind" do
    assert_winners([straight_flush, four_of_a_kind], [straight_flush])
  end

  test "Four of a kind beats full house" do
    assert_winners([four_of_a_kind, full_house], [four_of_a_kind])
  end

  test "Full house beats flush" do
    assert_winners([full_house, flush], [full_house])
  end

  test "Flush beats straight" do
    assert_winners([flush, straight], [flush])
  end

  test "Straight beats three of a kind" do
    assert_winners([straight, three_of_a_kind], [straight])
  end

  test "Three of a kind beats two pair" do
    assert_winners([three_of_a_kind, two_pair], [three_of_a_kind])
  end

  test "Two pairs beats pairs" do
    assert_winners([two_pair, pair], [two_pair])
  end

  test "Pairs beats high card" do
    assert_winners([pair], [high_card])
  end
end
