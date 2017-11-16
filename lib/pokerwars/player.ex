defmodule Pokerwars.Player do
  defstruct name: '', hand: []
  alias Pokerwars.Player

  def create(name) do
    %Player{name: name}
  end

end
