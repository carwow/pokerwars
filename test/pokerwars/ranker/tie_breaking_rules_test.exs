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

  test "An ace lower straight flush losses against any other kind of straight flush" do
    high_straight_flush = "Jc 10c 9c 8c 7c"
    low_straight_flush = "Ac 2c 3c 4c 5c"

    assert_winners([low_straight_flush, high_straight_flush], [high_straight_flush])
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

  test "Two straights with the same high card are a tie" do
    straight = "10c Jd Qc Kh As"
    another_straight = "10h Js Qh Ks Ad"

    assert_winners([straight, another_straight], [another_straight, straight])
  end

  test "The straight with the highest card wins" do
    high_straight = "10c Jd Qc Kh As"
    low_straight = "9h 10s Js Qh Ks"

    assert_winners([high_straight, low_straight], [high_straight])
  end

  test "An ace lower straight losses against any other kind of straight" do
    high_straight = "Jc 10d 9c 8h 7c"
    low_straight = "Ad 2h 3c 4h 5c"

    assert_winners([low_straight, high_straight], [high_straight])
  end

  test "An ace high straight wins against a king high straight" do
    high_straight = "Ad Qh Kc Jh 10c"
    low_straight = "6c 10d 9c 8h 7c"

    assert_winners([low_straight, high_straight], [high_straight])
  end

  test "Highested ranked three of a kind wins" do
    high_three_of_a_kind = "10c 10d 10s 3h 2h"
    low_three_of_a_kind = "5c 5d 5s 3h 2h"

    assert_winners([high_three_of_a_kind, low_three_of_a_kind], [high_three_of_a_kind])
  end

  test "Two identical three of a kind hands are a tie" do
    three_of_a_kind = "10c 10d 10s 3h 2h"
    another_three_of_a_kind = "10c 10d 10s 3h 2h"

    assert_winners([three_of_a_kind, another_three_of_a_kind], [another_three_of_a_kind, three_of_a_kind])
  end

  test "The two kickers are used to break a three of a kind tie" do
    winners_and_losers = [
      ["10s 10h 10d 5s 3d", "10s 10h 10d 4s 3d"],
      ["10s 10h 10d 5s 3d", "10s 10h 10d 5s 2d"]
    ]

    assertion = fn [winner | [loser | _]] ->
      assert_winners([winner, loser], [winner])
    end

    winners_and_losers |> Enum.each(assertion)
  end

  test "Two identical two pair with same kicker are a tie" do
    two_pair = "10d 10s Kd Ks 4h"
    another_two_pair = "10d 10s Kd Ks 4h"

    assert_winners([two_pair, another_two_pair], [another_two_pair, two_pair])
  end

  test "Highest pair in a two pair wins" do
    high_two_pair = "10d 10s Kd Ks 4h"
    low_two_pair = "10d 10s Qd Qs 4h"

    assert_winners([high_two_pair, low_two_pair], [high_two_pair])
  end

  test "Second highest pair wins when first one is the same" do
    high_two_pair = "10d 10s Kd Ks 4h"
    low_two_pair = "8d 8s Kd Ks 4h"

    assert_winners([high_two_pair, low_two_pair], [high_two_pair])
  end

  test "Kicker is used to break a tie when identical two pair" do
    high_two_pair = "10d 10s Kd Ks 4h"
    low_two_pair = "10h 10c Kd Ks 2h"

    assert_winners([high_two_pair, low_two_pair], [high_two_pair])
  end

  test "Same pair ranks and same kickers are a tie" do
    pair = "Qd Qs Kd Js 4h"
    another_pair = "Qh Qd Ks Jh 4d"

    assert_winners([pair, another_pair], [another_pair, pair])
  end

  test "Higher ranked pair wins" do
    high_pair = "Qd Qs Kd Js 4h"
    low_pair = "10h 10c Kd Js 4h"

    assert_winners([high_pair, low_pair], [high_pair])
  end

  test "The three kickers are used to break a pair tie" do
    winners_and_losers = [
      ["10s 10h Jd 5s 3d", "10s 10h 9d 5s 3d"],
      ["10s 10h Jd 5s 3d", "10s 10h Jd 4s 3d"],
      ["10s 10h Jd 5s 3d", "10s 10h Jd 5s 2d"]
    ]

    assertion = fn [winner | [loser | _]] ->
      assert_winners([winner, loser], [winner])
    end

    winners_and_losers |> Enum.each(assertion)
  end

  test "Two high card hands with identical kickers are a tie" do
    high_card = "Kd Js 9h 5s 3d"
    another_high_card = "Kd Js 9h 5s 3d"

    assert_winners([high_card, another_high_card], [another_high_card, high_card])
  end

  test "High card tie breaking uses all cards as kickerss" do
    winners_and_losers = [
      ["Kd Js 9h 5s 3d", "Qd Js 9h 5s 3d"],
      ["Kd Js 9h 5s 3d", "Kd 10s 9h 5s 3d"],
      ["Kd Js 9h 5s 3d", "Kd Js 8h 5s 3d"],
      ["Kd Js 9h 5s 3d", "Kd Js 9h 4s 3d"],
      ["Kd Js 9h 5s 3d", "Kd Js 9h 5s 2d"],
    ]

    assertion = fn [winner | [loser | _]] ->
      assert_winners([winner, loser], [winner])
    end

    winners_and_losers |> Enum.each(assertion)
  end
end
