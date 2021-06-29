defmodule KironAcs.Pregnants.Get do
  import Ecto.Query

  alias Ecto.Multi

  alias KironAcs.{Pregnant, Repo}

  def by_id(id) do
    case Repo.get(Pregnant, id) do
      nil -> {:error, "Pregnant not found!"}
      pregnant -> {:ok, pregnant}
    end
  end

  def by_cpf(cpf) do
    case Repo.get_by(Pregnant, cpf: cpf) do
      nil -> {:error, "Pregnant not found!"}
      pregnant -> {:ok, pregnant}
    end
  end

  def get_all do
    Multi.new()
    |> Multi.run(:list_pregnants, fn repo, _changes ->
      get_all_pregnants(repo)
    end)
    |> Multi.run(:preload_data, fn repo, %{list_pregnants: pregnants} ->
      preload_data(repo, pregnants)
    end)
    |> run_transaction()
  end

  def get_all_by_agent_id(agent_id) do
    Multi.new()
    |> Multi.run(:list_pregnants_by_agent_id, fn repo, _changes ->
      get_pregnants_by_agent_id(repo, agent_id)
    end)
    |> Multi.run(:preload_data, fn repo, %{list_pregnants_by_agent_id: pregnants} ->
      preload_data(repo, pregnants)
    end)
    |> run_transaction()
  end

  defp get_all_pregnants(repo) do
    list_pregnants =
      Pregnant
      |> repo.all()

    List.to_tuple([:ok, list_pregnants])
  end

  defp get_pregnants_by_agent_id(repo, agent_id) do
    query = from(p in Pregnant, where: p.agent_id == ^agent_id)

    list_pregnants =
      query
      |> repo.all()

    List.to_tuple([:ok, list_pregnants])
  end

  defp preload_data(repo, pregnants) do
    {:ok, repo.preload(pregnants, [:agent])}
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} ->
        {:error, reason}

      {:ok, %{preload_data: pregnants}} ->
        {:ok, pregnants}
    end
  end
end
