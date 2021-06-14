defmodule KironAcs do
  alias KironAcs.Agents.Create, as: AgentCreate

  defdelegate create_agent(params), to: AgentCreate, as: :call
end
