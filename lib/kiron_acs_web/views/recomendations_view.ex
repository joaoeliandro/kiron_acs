defmodule KironAcsWeb.RecomendationsView do
  use KironAcsWeb, :view

  alias KironAcs.Recomendation

  def render("create.json", %{recomendation: %Recomendation{} = recomendation}) do
    recomendation
  end
end
