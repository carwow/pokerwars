defmodule Pokerwars.TestHelpers do
  import ExUnit.Assertions
  alias Pokerwars.{Player}

  def assert_score(card_strings, expected_score) do
    cards = parse_cards(card_strings)
    score = Pokerwars.Hand.score(cards).name
    assertion = (score == expected_score)
    message = "Expected score of #{print_cards(cards)} to be #{expected_score} but was #{score}"
    assert(assertion, message)
  end

  def assert_winners(hand_strings, expected_winner_strings) do
    hands = parse_hands(hand_strings)
    expected_winners = parse_hands(expected_winner_strings)

    winners = Pokerwars.Ranker.decide_winners(hands)

    assertion = (winners == expected_winners)
    message = "Expected winners to be [#{print_hands(expected_winners)}] but it was [#{print_hands(winners)}]"

    assert(assertion, message)
  end

  defp print_hands(hands) do
    hands
    |> Enum.map(fn h -> print_cards(h) end)
    |> Enum.join(", ")
  end

  defp parse_hands(hand_strings) do
    Enum.map(hand_strings, fn h -> parse_cards(h) end)
  end

  defp print_cards(cards) do
    cards
    |> Enum.map(&(Pokerwars.Card.print(&1)))
    |> Enum.join(" ")
  end

  def parse_cards(card_strings) do
    card_strings
    |> String.split(" ")
    |> Enum.map(&(Pokerwars.Card.parse(&1)))
  end

  def jade do
    Player.create("Jade")
  end

  def david do
    Player.create("David")
  end

  def step(message) do
    IO.puts message
  end
end

ExUnit.start()
