defmodule KironAcs do
  alias KironAcs.Agents.Create, as: AgentsCreate

  alias KironAcs.Pregnants.Create, as: PregnantsCreate
  alias KironAcs.Pregnants.Get, as: PregnantsGet
  alias KironAcs.Pregnants.Mail.HelperNotification, as: PregnantsProvidersHelperMail

  alias KironAcs.Recomendations.Create, as: RecomendationsCreate
  alias KironAcs.Recomendations.Get, as: RecomendationsGet

  defdelegate create_agent(params), to: AgentsCreate, as: :call

  defdelegate create_pregnant(params), to: PregnantsCreate, as: :call
  defdelegate get_all_pregnants(), to: PregnantsGet, as: :get_all
  defdelegate get_pregnants_by_agent_id(agent_id), to: PregnantsGet, as: :get_all_by_agent_id
  defdelegate get_pregnants_by_situation(agent_id, situation), to: PregnantsGet, as: :get_all_by_situation
  defdelegate send_helper_mail(params), to: PregnantsProvidersHelperMail, as: :send

  defdelegate create_recomendation(params), to: RecomendationsCreate, as: :call
  defdelegate get_all_recomendations(), to: RecomendationsGet, as: :get_all

  defdelegate get_recomendations_by_agent_id(agent_id),
    to: RecomendationsGet,
    as: :get_all_by_agent_id

  defdelegate get_recomendations_by_pregnant_id(pregnant_id),
    to: RecomendationsGet,
    as: :get_all_by_pregnant_id
end
