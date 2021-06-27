defmodule KironAcs.Recomendations.Create do
  alias KironAcs.{Recomendation, Repo}

  def call(params) do
    params
    |> Recomendation.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Recomendation{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, %{result: result, status: :bad_request}}
  end
end
