defmodule Pokerwars.TieBreakingRulesTest do
  use ExUnit.Case, async: true

  import Pokerwars.TestHelpers

  test "Highest rank straight flush wins" do
    high_straight_flush = "5c 6c 7c 8c 9c"
    low_straight_flush = "4c 5c 6c 7c 8c"

    assert_winners([high_straight_flush, low_straight_flush], [high_straight_flush])
  end

  test "Suits doesn't matter and identical ranks both win" do
    high_straight_flush = "5c 6c 7c 8c 9c"
    another_high_straight_flush = "5d 6d 7d 8d 9d"

    assert_winners([high_straight_flush, another_high_straight_flush], [another_high_straight_flush, high_straight_flush])
  end

  test "An ace high straight flush wins against a king high royal flush" do
    royal_flush = "Ac Kc Qc Jc 10c"
    king_high_straight_flush = "Kd Qd Jd 10d 9d"

    assert_winners([royal_flush, king_high_straight_flush], [royal_flush])
  end

  test "Same four-of-a-kind rank and kicker both wins" do
    four_of_a_kind = "Ac Ad Ah As 8h"
    another_four_of_a_kind = "Ac Ad Ah As 8h"

    assert_winners([four_of_a_kind, another_four_of_a_kind], [another_four_of_a_kind, four_of_a_kind])
  end

  test "Highest four-of-a-kind wins" do
    high_four_of_a_kind = "Ac Ad Ah As 8h"
    low_four_of_a_kind = "Kc Kd Kh Ks 8h"

    assert_winners([high_four_of_a_kind, low_four_of_a_kind], [high_four_of_a_kind])
  end

  test "Kicker decides winner when same four-of-a-kind rank" do
    high_four_of_a_kind = "Ac Ad Ah As 8h"
    low_four_of_a_kind = "Ac Ad Ah As 5h"

    assert_winners([high_four_of_a_kind, low_four_of_a_kind], [high_four_of_a_kind])
  end

  test "Full house with same three-of-a-kind and same pair is a tie" do
    full_house = "Ac Ad Ah 10s 10h"
    same_full_house = "As Ad Ah 10c 10d"

    assert_winners([full_house, same_full_house], [same_full_house, full_house])
  end

  test "Full house with higher three of a kind wins" do
    high_full_house = "Ac Ad Ah 3s 3h"
    low_full_house = "Ks Kd Kh 10c 10d"

    assert_winners([high_full_house, low_full_house], [high_full_house])
  end

  test "Pair decides the winner when same full house three-of-a-kind rank" do
    low_full_house = "Ac Ad Ah 3s 3h"
    high_full_house = "As Ad Ah 10c 10d"

    assert_winners([high_full_house, low_full_house], [high_full_house])
  end

  test "Two flushes with same ranks are a tie" do
    clubs_flush = "10c Jc 4c 7c Ac"
    hearths_flush = "10h Jh 4h 7h Ah"

    assert_winners([clubs_flush, hearths_flush], [hearths_flush, clubs_flush])
  end

  test "Kickers decide winner in a flush tie break" do
    winners_and_losers = [
      ["Ac Jc 9c 7c 4c", "Kc Jc 9c 7c 4c"],
      ["Ac Jc 9c 7c 4c", "Ac 10c 9c 7c 4c"],
      ["Ac Jc 9c 7c 4c", "Ac Jc 8c 7c 4c"],
      ["Ac Jc 9c 7c 4c", "Ac Jc 9c 6c 4c"],
      ["Ac Jc 9c 7c 4c", "Ac Jc 9c 7c 3c"]
    ]

    assertion = fn [winner | [loser | _]] ->
      assert_winners([winner, loser], [winner])
    end

    winners_and_losers |> Enum.each(assertion)
  end
end
