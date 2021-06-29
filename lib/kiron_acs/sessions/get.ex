defmodule KironAcs.Sessions.Get do
  alias KironAcs.Agents.Get, as: AgentGet
  alias KironAcs.Pregnants.Get, as: PregnantGet

  def by_id(%{"id" => id, "type" => "agent"}) do
    AgentGet.by_id(id)
  end

  def by_id(%{"id" => id, "type" => "pregnant"}) do
    PregnantGet.by_id(id)
  end

  def by_user({:number_registration, number_registration}) do
    AgentGet.by_number_registration(number_registration)
  end

  def by_user({:cpf, cpf}) do
    PregnantGet.by_cpf(cpf)
  end
end
