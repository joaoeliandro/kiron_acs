defmodule KironAcsWeb.PregnantsView do
  use KironAcsWeb, :view

  alias KironAcs.Pregnant

  def render("create.json", %{pregnant: %Pregnant{} = pregnant}) do
    pregnant
  end

  def render("list_pregnants.json", %{pregnants: [%Pregnant{} | _tail] = pregnants}) do
    %{
      pregnants: pregnants
    }
  end

  def render("list_pregnants_by_agent_id.json", %{pregnants: [%Pregnant{} | _tail] = pregnants}) do
    %{
      pregnants: pregnants
    }
  end

  def render("helper_mail.json", %{message: message}) do
    %{
      message: message
    }
  end
end
