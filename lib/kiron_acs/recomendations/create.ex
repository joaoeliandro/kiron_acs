defmodule KironAcs.Recomendations.Create do
  alias KironAcs.{Recomendation, Repo}

  alias Ecto.Multi

  def call(params) do
    Multi.new()
    |> Multi.run(:insert_recomendation, fn repo, _changes ->
      insert_recomendation(repo, params)
    end)
    |> Multi.run(:preload_data, fn repo, %{insert_recomendation: recomendation} ->
      preload_data(repo, recomendation)
    end)
    |> run_transaction()
  end

  defp insert_recomendation(repo, params) do
    params
    |> Recomendation.changeset()
    |> repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Recomendation{}} = result), do: result

  defp handle_insert({:error, result}) do
    {:error, %{result: result, status: :bad_request}}
  end

  defp preload_data(repo, recomendation) do
    {:ok, repo.preload(recomendation, [:agent, pregnant: [:agent]])}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{preload_data: recomendation}} ->
        {:ok, recomendation}
    end
  end
end
