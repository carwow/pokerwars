defmodule Pokerwars.DealerTest do
  use ExUnit.Case, async: true

  alias Pokerwars.{Hand, Dealer}

  doctest Pokerwars.Dealer

  describe "compare different hands" do
    test "pair is stronger than high card hand" do
      high_hand = Hand.parse("2s 3h 5d 7s Js")
      one_pair_hand = Hand.parse("3s 4d 10h 8s 8d")

      assert Dealer.stronger_hand(high_hand, one_pair_hand) == one_pair_hand
    end

    test "two pairs are stronger than one pair" do
      one_pair_hand = Hand.parse("3s 4d 10h 8s 8d")
      two_pairs_hand = Hand.parse("3s 3h Ad As 5h")

      assert Dealer.stronger_hand(two_pairs_hand, one_pair_hand) == two_pairs_hand
    end

    test "three of a kind are stronger than two pairs" do
      three_of_a_hand = Hand.parse("3d 4s As Ah Ac")
      two_pairs_hand = Hand.parse("3s 3h Ad As 5h")

      assert Dealer.stronger_hand(two_pairs_hand, three_of_a_hand) == three_of_a_hand
    end

    test "straight is stronger than three of a kind" do
      three_of_a_hand = Hand.parse("3d 4s As Ah Ac")
      straight = Hand.parse("As 3s 2c 5d 4h")

      assert Dealer.stronger_hand(straight, three_of_a_hand) == straight
    end

    test "flush is stronger than Straight" do
      flush = Hand.parse("8h 2h Ah 9h 4h")
      straight = Hand.parse("As 3s 2c 5d 4h")

      assert Dealer.stronger_hand(straight, flush) == flush
    end

    test "full-house is stronger than flush" do
      flush = Hand.parse("8h 2h Ah 9h 4h")
      full_house = Hand.parse("3s 3h 3c Ad As")

      assert Dealer.stronger_hand(full_house, flush) == full_house
    end

    test "four of a kind are stronger than full-house" do
      four_of_a_kind = Hand.parse("7h 7d 7s 4s 7c")
      full_house = Hand.parse("3s 3h 3c Ad As")

      assert Dealer.stronger_hand(full_house, four_of_a_kind) == four_of_a_kind
    end

    test "straight flush is stronger than four of a kind" do
      four_of_a_kind = Hand.parse("7h 7d 7s 4s 7c")
      straight = Hand.parse("Ad 10d 11d 13d 12d")

      assert Dealer.stronger_hand(straight, four_of_a_kind) == straight
    end
  end

  describe "compare same hands" do
    test "high card hand with higher highest card is stronger" do
      high_hand = Hand.parse("2s 3h 5d 7s Js")
      higher_high_hand = Hand.parse("Ks 8h 6d 3s Jh")

      assert Dealer.stronger_hand(higher_high_hand, high_hand) == higher_high_hand
    end

    test "high card hand with third highest card is stronger" do
      high_hand = Hand.parse("Kh 3h 5d 7s Js")
      higher_high_hand = Hand.parse("Ks 8h 6d 3s Jh")

      assert Dealer.stronger_hand(higher_high_hand, high_hand) == higher_high_hand
    end

    test "splits the pot when high card hands are equal" do
      high_hand_1 = Hand.parse("Kh 3h 5d 7s Js")
      high_hand_2 = Hand.parse("Ks 3d 5h 7h Jh")

      assert Dealer.stronger_hand(high_hand_1, high_hand_2) == :split_pot
    end

    test "the pair hand with the highest pair is stronger" do
      pair_hand = Hand.parse("3s 3h Ad Ks 5h")
      higher_pair_hand = Hand.parse("3s 6h Qd 2s 6s")

      assert Dealer.stronger_hand(higher_pair_hand, pair_hand) == higher_pair_hand
    end

    test "the pair hand with the highest kicker is stronger when the pairs are equal" do
      higher_kicker_pair_hand = Hand.parse("3s 3h Ad Ks 5h")
      pair_hand = Hand.parse("3d 6h Qd As 3c")

      assert Dealer.stronger_hand(pair_hand, higher_kicker_pair_hand) == higher_kicker_pair_hand
    end

    test "the two-pair hand with the highest pair is stronger" do
      two_pair_hand = Hand.parse("3d 6s 6h 10s 10h")
      better_two_pair_hand = Hand.parse("2d 5c 5d Jc Jd")

      assert Dealer.stronger_hand(two_pair_hand, better_two_pair_hand) == better_two_pair_hand
    end

    test "the two-pair hand with the highest second pair is stronger when the first are equal" do
      two_pair_hand = Hand.parse("Jd 5s 5h 10s 10h")
      better_two_pair_hand = Hand.parse("3d 6c 6d 10c 10d")

      assert Dealer.stronger_hand(two_pair_hand, better_two_pair_hand) == better_two_pair_hand
    end

    test "the two-pair hand with the highest kicker is stronger when both pairs are equal" do
      two_pair_hand = Hand.parse("3d 5s 5h 10s 10h")
      better_two_pair_hand = Hand.parse("Qd 5c 5d 10c 10d")

      assert Dealer.stronger_hand(two_pair_hand, better_two_pair_hand) == better_two_pair_hand
    end

    test "the three-of-a-kind hand with the highest three-of-a-kind is stronger" do
      three_of_a_kind_hand = Hand.parse("7h 3d 7s 4s 7c")
      better_three_of_a_kind_hand = Hand.parse("3d 4s Qs Qh Qc")

      assert Dealer.stronger_hand(three_of_a_kind_hand, better_three_of_a_kind_hand) == better_three_of_a_kind_hand
    end

    test "the straight hand with the highest rank card is stronger" do
      straight_hand = Hand.parse("6s 3s 2c 5d 4h")
      better_straight_hand = Hand.parse("Js 8s 10c 7d 9h")

      assert Dealer.stronger_hand(straight_hand, better_straight_hand) == better_straight_hand
    end

    test "the straight hand with the highest rank card is stronger when Ace is used as 1" do
      straight_hand = Hand.parse("As 2d 3c 4h 5s")
      better_straight_hand = Hand.parse("9s 10s Jc Kd Qh")

      assert Dealer.stronger_hand(straight_hand, better_straight_hand) == better_straight_hand
    end

    test "the straight hand with the highest rank of Ace is stronger when Aces are used as 1 and 14" do
      straight_hand = Hand.parse("As 2d 3c 4h 5s")
      better_straight_hand = Hand.parse("As 10s Jc Kd Qh")

      assert Dealer.stronger_hand(straight_hand, better_straight_hand) == better_straight_hand
    end

    test "the flush hand with the highest rank card is stronger" do
      flush_hand = Hand.parse("8h 2h Jh 7h 4h")
      better_flush_hand = Hand.parse("3d 2d Ad 9d 4d")

      assert Dealer.stronger_hand(flush_hand, better_flush_hand) == better_flush_hand
    end

    test "the full-house hand with the highest three matching cards is stronger" do
      full_house_hand = Hand.parse("3s 3h 3c Ad As")
      better_full_house_hand = Hand.parse("Js Jh Jc 6d 6s")

      assert Dealer.stronger_hand(full_house_hand, better_full_house_hand) == better_full_house_hand
    end

    test "the four-of-a-kind hand with the highest four-of-a-kind is stronger" do
      four_of_a_kind_hand = Hand.parse("3s 3h 3c 3d As")
      better_four_of_a_kind_hand = Hand.parse("4s 4h 4c 4d 6s")

      assert Dealer.stronger_hand(four_of_a_kind_hand, better_four_of_a_kind_hand) == better_four_of_a_kind_hand
    end

    test "the straight-flush hand with the highest straight-flush is stronger" do
      straight_flush = Hand.parse("Ah 3h 2h 5h 4h")
      better_straight_flush = Hand.parse("Jh 8h 10h 7h 9h")

      assert Dealer.stronger_hand(straight_flush, better_straight_flush) == better_straight_flush
    end
  end

  describe "Community card game" do
    # At the moment works out of the box without any additional code.
    test "the three-of-a-kind hand with the highest kicker is stronger when the three-of-a-kind are equal" do
      three_of_a_kind_hand = Hand.parse("7h 3d 7s Js 7c")
      better_three_of_a_kind_hand = Hand.parse("5d Jd 7s 7h 7c")

      assert Dealer.stronger_hand(three_of_a_kind_hand, better_three_of_a_kind_hand) == better_three_of_a_kind_hand
    end

    test "the full-house hand with the highest two matching cards is stronger when the full-house are equal" do
      full_house_hand = Hand.parse("3s 3h 3c Qd Qs")
      better_full_house_hand = Hand.parse("3d 3s 3c Kd Ks")

      assert Dealer.stronger_hand(full_house_hand, better_full_house_hand) == better_full_house_hand
    end

    test "the four-of-a-kind hand with the highest kicker is stronger when the four-of-a-kind are equal" do
      four_of_a_kind_hand = Hand.parse("4s 4h 4c 4d Js")
      better_four_of_a_kind_hand = Hand.parse("4s 4h 4c 4d Ks")

      assert Dealer.stronger_hand(four_of_a_kind_hand, better_four_of_a_kind_hand) == better_four_of_a_kind_hand
    end
  end
end
