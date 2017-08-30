defmodule Pokerwars.Helpers do
  def maxes_by(collection, func) do
    maxes_by(collection, func, [])
  end

  defp maxes_by([], func, result), do: result

  defp maxes_by([head | rest], func, []) do
    maxes_by(rest, func, [head])
  end

  defp maxes_by([head | rest], func, [first_result | other_results]) do
    current_value = func.(head)
    max_value = func.(first_result)

    results =
    cond do
      current_value > max_value -> [head]
      current_value == max_value -> [head] ++ [first_result] ++ other_results
      current_value < max_value -> [first_result] ++ other_results
    end

    maxes_by(rest, func, results)
  end
end
