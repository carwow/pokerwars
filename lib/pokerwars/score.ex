defmodule Pokerwars.Score do
  alias Pokerwars.Score

  defstruct [
    :name,
    :value,
    :tie_breaking_ranks
  ]

  def straight_flush(primary_rank) do
    %Score{
      name: :straight_flush,
      value: 9,
      tie_breaking_ranks: [primary_rank]
    }
  end

  def four_of_a_kind(primary_rank, secondary_rank) do
    %Score{
      name: :four_of_a_kind,
      value: 8,
      tie_breaking_ranks: [primary_rank, secondary_rank]
    }
  end

  def full_house(primary_rank, secondary_rank) do
    %Score{
      name: :full_house,
      value: 7,
      tie_breaking_ranks: [primary_rank, secondary_rank]
    }
  end

  def flush(kickers) do
    sorted_kickers = kickers
    |> Enum.sort
    |> Enum.reverse

    %Score{name: :flush, value: 6, tie_breaking_ranks: sorted_kickers}
  end

  def straight(primary_rank) do
    %Score{
      name: :straight,
      value: 5,
      tie_breaking_ranks: [primary_rank]}
  end

  def three_of_a_kind(primary_rank, kickers) do
    %Score{
      name: :three_of_a_kind,
      value: 4,
      tie_breaking_ranks: [primary_rank] ++ kickers
    }
  end

  def two_pair(primary_rank, secondary_rank, kicker) do
    %Score{
      name: :two_pair,
      value: 3,
      tie_breaking_ranks: [primary_rank, secondary_rank, kicker]
    }
  end

  def pair(primary_rank, kickers) do
    %Score{
      name: :pair,
      value: 2,
      tie_breaking_ranks: [primary_rank] ++ kickers
    }
  end

  def high_card(kickers) do
    %Score{name: :high_card, value: 1, tie_breaking_ranks: kickers}
  end
end
