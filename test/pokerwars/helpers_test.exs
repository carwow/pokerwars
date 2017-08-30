defmodule Pokerwars.HelpersTest do
  use ExUnit.Case, async: true
  alias Pokerwars.Helpers
  doctest Pokerwars.Helpers

  test "maxes_by empty list" do
    assert Helpers.maxes_by([], &String.length/1) == []
  end

  test "maxes_by with one element returns one element" do
    assert Helpers.maxes_by(["hello"], &String.length/1) == ["hello"]
  end

  test "maxes_by with multiple elements returns the ones whom have the highest result when passed function applied" do
    assert Helpers.maxes_by(["hello", "hi", "salut"], &String.length/1) == ["salut", "hello"]
  end
end
