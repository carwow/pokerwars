defmodule Pokerwars.Score do
  alias Pokerwars.Score

  defstruct [
    :name,
    :value,
    :highest_rank,
    :triplet_rank,
    :first_pair_rank,
    :second_pair_rank,
    :kickers
  ]

  def straight_flush do
    %Score{name: :straight_flush, value: 9}
  end

  def four_of_a_kind do
    %Score{name: :four_of_a_kind, value: 8}
  end

  def full_house do
    %Score{name: :full_house, value: 7}
  end

  def flush do
    %Score{name: :flush, value: 6}
  end

  def straight do
    %Score{name: :straight, value: 5}
  end

  def three_of_a_kind do
    %Score{name: :three_of_a_kind, value: 4}
  end

  def two_pair do
    %Score{name: :two_pair, value: 3}
  end

  def pair do
    %Score{name: :pair, value: 2}
  end

  def high_card do
    %Score{name: :high_card, value: 1}
  end
end
