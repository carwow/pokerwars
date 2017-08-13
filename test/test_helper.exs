defmodule Pokerwars.TestHelpers do
  import ExUnit.Assertions

  def assert_score(card_strings, expected_score) do
    cards = Pokerwars.Hand.parse(card_strings)
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
end
ExUnit.start()
