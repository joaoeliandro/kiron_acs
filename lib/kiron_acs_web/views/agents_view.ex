defmodule KironAcsWeb.AgentsView do
  use KironAcsWeb, :view

  alias KironAcs.Agent

  def render("create.json", %{token: token, agent: %Agent{} = agent}) do
    %{
      agent: agent,
      token: token
    }
  end
end
