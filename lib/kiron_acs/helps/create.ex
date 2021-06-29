defmodule KironAcs.Helps.Create do
  alias KironAcs.{Help, Repo}

  alias Ecto.Multi

  def call(params) do
    Multi.new()
    |> Multi.run(:insert_help, fn repo, _changes ->
      insert_help(repo, params)
    end)
    |> Multi.run(:preload_data, fn repo, %{insert_help: help} ->
      preload_data(repo, help)
    end)
    |> run_transaction()
  end

  defp insert_help(repo, params) do
    params
    |> Help.changeset()
    |> repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Help{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, %{result: result, status: :bad_request}}
  end

  defp preload_data(repo, help) do
    {:ok, repo.preload(help, [:agent, pregnant: [:agent]])}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{preload_data: help}} ->
        {:ok, help}
    end
  end
end
