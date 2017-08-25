defmodule Pokerwars.RankerTest do
  use ExUnit.Case, async: true

  import Pokerwars.TestHelpers

  doctest Pokerwars.Ranker

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

    assert_winners([pair], [high_card])
  end
end
