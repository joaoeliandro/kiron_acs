defmodule KironAcsWeb.RecomendationsView do
  use KironAcsWeb, :view

  alias KironAcs.Recomendation

  def render("create.json", %{recomendation: %Recomendation{} = recomendation}) do
    render_one(recomendation, __MODULE__, "recomendation.json")
  end

  def render("list_recomendations.json", %{
        recomendations: recomendations
      }) do
    render_many(recomendations, KironAcsWeb.RecomendationsView, "recomendation.json")
  end

  def render("list_recomendations_by_agent_id.json", %{
        recomendations: recomendations
      }) do
    %{
      recomendations: recomendations
    }
  end

  def render("list_recomendations_by_pregnant_id.json", %{
        recomendations: recomendations
      }) do
    %{
      recomendations: recomendations
    }
  end

  def render("recomendation.json", %{recomendations: %Recomendation{} = recomendation}) do
    recomendation
  end
end
