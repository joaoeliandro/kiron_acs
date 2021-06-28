defmodule KironAcs.Pregnants.Create do
  alias KironAcs.{Pregnant, Repo}

  alias Ecto.Multi

  def call(params) do
    Multi.new()
    |> Multi.run(:insert_pregnant, fn repo, _changes ->
      insert_pregnant(repo, params)
    end)
    |> Multi.run(:preload_data, fn repo, %{insert_pregnant: pregnant} ->
      preload_data(repo, pregnant)
    end)
    |> run_transaction()
  end

  defp insert_pregnant(repo, params) do
    params
    |> Pregnant.changeset()
    |> repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Pregnant{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, %{result: result, status: :bad_request}}
  end

  defp preload_data(repo, pregnant) do
    {:ok, repo.preload(pregnant, [:agent])}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{preload_data: pregnant}} ->
        {:ok, pregnant}
    end
  end
end
