defmodule Pokerwars.TestHelpers do
  import ExUnit.Assertions

  def assert_score(card_strings, expected_score) do
    cards = Pokerwars.Hand.parse_cards(card_strings)
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

  def assert_set_equal(real_hand, expected_hand) do
    assert Enum.into(real_hand, %MapSet{}) == Enum.into(expected_hand, %MapSet{})
  end
end
ExUnit.start()
