defmodule Pokerwars.Hand.FlushTest do
  use ExUnit.Case, async: true
  import Pokerwars.TestHelpers
  doctest Pokerwars.Hand

  test "High Card" do
    assert_score("2s 3h 5d 7s Js", :high_card)
  end

  test "Pair" do
    assert_score("As Ah 3d 4s 5h", :pair)
    assert_score("3d 10s 10h 4s 5h", :pair)
    assert_score("3d 4s 5h 10s 10h", :pair)
    assert_score("3d 7s 4h 7h 5h", :pair)
  end

  test "Two Pair" do
    assert_score("As Ah 3d 3s 5h", :two_pair)
    assert_score("3s 3h Ad As 5h", :two_pair)
    assert_score("4d 10s 10h 2s 4h", :two_pair)
    assert_score("3d 5s 5h 10s 10h", :two_pair)
    assert_score("3d 7s 4s 7h 3h", :two_pair)
  end

  test "Three of a kind" do
    assert_score("As Ah Ac 3d 4s", :three_of_a_kind)
    assert_score("3d 4s As Ah Ac", :three_of_a_kind)
    assert_score("7h 3d 7s 4s 7c", :three_of_a_kind)
  end

  test "Straight" do
    assert_score("As 2c 3s 4h 5d", :straight)
    assert_score("As 3s 2c 5d 4h", :straight)
    assert_score("As 10s Jc Kd Qh", :straight)
  end

  test "Full house" do
    assert_score("As Ah Ac 3d 3s", :full_house)
    assert_score("3s 3h 3c Ad As", :full_house)
    assert_score("3s Ad 3h As 3c", :full_house)
  end

  test "Flush" do
    assert_score("8h 2h Ah 9h 4h", :flush)
  end

  test "Four of a kind" do
    assert_score("As Ah Ac Ad 4s", :four_of_a_kind)
    assert_score("3d 5d 5s 5h 5c", :four_of_a_kind)
    assert_score("7h 7d 7s 4s 7c", :four_of_a_kind)
  end

  test "Straight Flush" do
    assert_score("As 2s 3s 4s 5s", :straight_flush)
    assert_score("Ah 3h 2h 5h 4h", :straight_flush)
    assert_score("Ad 10d 11d 13d 12d", :straight_flush)
  end
end
