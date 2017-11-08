defmodule Pokerwars.Player do
  defstruct [:name, :hand]

  def create do
    %__MODULE__{name: 'test', hand: []}
  end

  def receive_card(%__MODULE__{hand: hand}, card) do
    %__MODULE__{hand: [card | hand]}
  end


  def cards(%__MODULE__{hand: hand}) do
    hand
  end
end
