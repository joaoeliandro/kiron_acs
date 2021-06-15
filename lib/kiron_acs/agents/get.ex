defmodule KironAcs.Agents.Get do
  alias KironAcs.{Agent, Repo}

  def by_id(id) do
    case Repo.get(Agent, id) do
      nil -> {:error, "Agent not found!"}
      agent -> {:ok, agent}
    end
  end
end
