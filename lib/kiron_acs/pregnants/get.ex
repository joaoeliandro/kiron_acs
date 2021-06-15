defmodule KironAcs.Pregnants.Get do
  import Ecto.Query

  alias KironAcs.{Pregnant, Repo}

  def get_all_by_agent_id(agent_id) do
    query = from(p in Pregnant, where: p.agent_id == ^agent_id)

    query
    |> Repo.all()
  end
end
