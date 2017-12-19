defmodule Pokerwars.Player do
  defstruct name: '', hand: [], stack: 0
  alias Pokerwars.Player

  def create(name, stack \\ 0) do
    %Player{name: name, stack: stack}
  end

  def clear_hand(%Player{} = player) do
    %{player | hand: []}
  end

  def add_card_to_hand(%Player{hand: hand} = player, card) do
    %{player | hand: hand ++ [card]}
  end
end
