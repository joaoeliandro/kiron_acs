defmodule KironAcsWeb.AgentsView do
  use KironAcsWeb, :view

  def render("create.json", %{agent: agent}) do
    %{
      agent: agent
    }
  end
end
