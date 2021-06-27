defmodule KironAcs.Recomendations.Get do
  import Ecto.Query

  alias Ecto.Multi

  alias KironAcs.{Recomendation, Repo}

  def get_all do
    Multi.new()
    |> Multi.run(:list_recomendations, fn repo, _changes ->
      get_all_recomendations(repo)
    end)
    |> Multi.run(:preload_data, fn repo, %{list_recomendations: recomendations} ->
      preload_data(repo, recomendations)
    end)
    |> run_transaction()
  end

  def get_all_by_agent_id(agent_id) do
    Multi.new()
    |> Multi.run(:list_recomendations_by_agent_id, fn repo, _changes ->
      get_recomendations_by_agent_id(repo, agent_id)
    end)
    |> Multi.run(:preload_data, fn repo, %{list_recomendations_by_agent_id: recomendations} ->
      preload_data(repo, recomendations)
    end)
    |> run_transaction()
  end

  def get_all_by_pregnant_id(pregnant_id) do
    Multi.new()
    |> Multi.run(:list_recomendations_by_pregnant_id, fn repo, _changes ->
      get_recomendations_by_pregnant_id(repo, pregnant_id)
    end)
    |> Multi.run(:preload_data, fn repo, %{list_recomendations_by_pregnant_id: recomendations} ->
      preload_data(repo, recomendations)
    end)
    |> run_transaction()
  end

  defp get_all_recomendations(repo) do
    list_recomendations =
      Recomendation
      |> repo.all()

    List.to_tuple([:ok, list_recomendations])
  end

  defp get_recomendations_by_agent_id(repo, agent_id) do
    query = from(r in Recomendation, where: r.agent_id == ^agent_id)

    list_recomendations =
      query
      |> repo.all()

    List.to_tuple([:ok, list_recomendations])
  end

  defp get_recomendations_by_pregnant_id(repo, pregnant_id) do
    query = from(r in Recomendation, where: r.pregnant_id == ^pregnant_id)

    list_recomendations =
      query
      |> repo.all()

    List.to_tuple([:ok, list_recomendations])
  end

  defp preload_data(repo, recomendations) do
    {:ok, repo.preload(recomendations, [:agent, :pregnant])}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{preload_data: recomendations}} ->
        {:ok, recomendations}
    end
  end
end
