defmodule KironAcs.Agents.Create do
  alias KironAcs.{Agent, Repo}

  def call(params) do
    params
    |> Agent.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Agent{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, %{result: result, status: :bad_request}}
  end
end
