defmodule KironAcs do
  alias KironAcs.Agents.Create, as: AgentsCreate

  alias KironAcs.Pregnants.Create, as: PregnantsCreate
  alias KironAcs.Pregnants.Get, as: PregnantsGet

  alias KironAcs.Recomendations.Create, as: RecomendationsCreate

  defdelegate create_agent(params), to: AgentsCreate, as: :call

  defdelegate create_pregnant(params), to: PregnantsCreate, as: :call
  defdelegate get_pregnants_by_agent_id(agent_id), to: PregnantsGet, as: :get_all_by_agent_id
  defdelegate get_all_pregnants(), to: PregnantsGet, as: :get_all

  defdelegate create_recomendation(params), to: RecomendationsCreate, as: :call
end
