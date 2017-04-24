defmodule Pokerwars.TestHelpers do
  import ExUnit.Assertions
  def assert_score(card_strings, expected_score) do
    cards = parse_cards(card_strings)
    score = Pokerwars.Hand.score(cards)
    assertion = (score == expected_score)
    message = "Expected score of #{print_cards(cards)} to be #{expected_score} but was #{score}"
    assert(assertion, message)
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
end
ExUnit.start()
