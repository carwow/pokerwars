defmodule Pokerwars.RankerTest do
  use ExUnit.Case, async: true

  import Pokerwars.TestHelpers

  doctest Pokerwars.Ranker

  describe "Ranker.decide_winners/1" do
    test "Order of hands does not matter" do
      straight_flush = "5c 6c 7c 8c 9c"
      four_of_a_kind = "Ah Ac As Ad 8c"

      assert_winners([straight_flush, four_of_a_kind], [straight_flush])
      assert_winners([four_of_a_kind, straight_flush], [straight_flush])
    end

    test "Straight flush beats four of a kind" do
      straight_flush = "5c 6c 7c 8c 9c"
      four_of_a_kind = "Ah Ac As Ad 8c"

      assert_winners([straight_flush, four_of_a_kind], [straight_flush])
    end

    test "Four of a kind beats full house" do
      four_of_a_kind = "Ah Ac As Ad 8c"
      full_house = "Kh Kc Ks 10h 10c"

      assert_winners([four_of_a_kind, full_house], [four_of_a_kind])
    end

    test "Full house beats flush" do
      full_house = "Kh Kc Ks 10h 10c"
      flush = "Qc 8c 6c 4c 3c"

      assert_winners([full_house, flush], [full_house])
    end

    test "Flush beats straight" do
      flush = "Qc 8c 6c 4c 3c"
      straight = "2d 3c 4s 5d 6c"

      assert_winners([flush, straight], [flush])
    end

    test "Straight beats three of a kind" do
      straight = "2d 3c 4s 5d 6c"
      three_of_a_kind = "Jc Jh Jd 5c 8d"

      assert_winners([straight, three_of_a_kind], [straight])
    end

    test "Three of a kind beats two pair" do
      three_of_a_kind = "Jc Jh Jd 5c 8d"
      two_pair = "10d 10c 6s 6c Kd"

      assert_winners([three_of_a_kind, two_pair], [three_of_a_kind])
    end

    test "Two pairs beats pairs" do
      two_pair = "10d 10c 6s 6c Kd"
      pair = "Ah Ac 8s 6h 2d"

      assert_winners([two_pair, pair], [two_pair])
    end

    test "Pairs beats high card" do
      pair = "Ah Ac 8s 6h 2d"
      high_card = "Kh Js 10c 6h 3d"

      assert_winners([pair, high_card], [pair])
    end

    test "Multiple winning hands are returned when tie occurs" do
      pair = "Ah Ac 8s 6h 2d"
      another_pair = "Ah Ac 8c 2h 6d"
      high_card = "Kh Js 10c 6h 3d"

      assert_winners([pair, another_pair, high_card], [another_pair, pair])
    end
  end

  describe "Ranker.decide_best_hand/1" do
    test "returns the best flush hand when given 7 cards and chooses 5" do
      set_of_seven_cards = "Ah Qd 7h Qc Jh Qh 3h"
      strongest_hand = "Ah 7h Jh Qh 3h"

      assert_best_hand(set_of_seven_cards, strongest_hand)
    end

    test "returns the best full house hand when given 7 cards and chooses 5" do
      set_of_seven_cards = "Ah Jd Js Qd Jh Qh 3h"
      strongest_hand = "Jd Js Qd Jh Qh"

      assert_best_hand(set_of_seven_cards, strongest_hand)
    end

    test "returns the best straight hand when given 7 cards and chooses 5" do
      set_of_seven_cards = "As 4d 4s 3d 5h 4h 2h"
      strongest_hand = "As 3d 5h 4h 2h"

      assert_best_hand(set_of_seven_cards, strongest_hand)
    end
  end
end
