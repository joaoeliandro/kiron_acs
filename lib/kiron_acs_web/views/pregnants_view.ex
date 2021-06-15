defmodule KironAcsWeb.PregnantsView do
  use KironAcsWeb, :view

  alias KironAcs.Pregnant

  def render("create.json", %{pregnant: pregnant}) do
    pregnant
  end

  def render("list_pregnants_by_agent_id.json", %{pregnants: [%Pregnant{} | _tail] = pregnants}) do
    %{
      pregnants: pregnants
    }
  end
end
