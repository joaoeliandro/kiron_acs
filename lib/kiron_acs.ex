defmodule KironAcs do
  alias KironAcs.Agents.Create, as: AgentCreate

  alias KironAcs.Pregnants.Create, as: PregnantsCreate
  alias KironAcs.Pregnants.Get, as: PregnantsGet

  defdelegate create_agent(params), to: AgentCreate, as: :call

  defdelegate create_pregnant(params), to: PregnantsCreate, as: :call
  defdelegate get_pregnants_by_agent_id(agent_id), to: PregnantsGet, as: :get_all_by_agent_id
end
