defmodule KironAcs.Pregnants.Create do
  alias KironAcs.{Pregnant, Repo}

  def call(params) do
    params
    |> Pregnant.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Pregnant{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, %{result: result, status: :bad_request}}
  end
end
