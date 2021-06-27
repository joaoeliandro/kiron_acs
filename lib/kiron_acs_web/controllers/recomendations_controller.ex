defmodule KironAcsWeb.RecomendationsController do
  use KironAcsWeb, :controller

  alias KironAcs.Recomendation

  alias KironAcsWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Recomendation{} = recomendation} <- KironAcs.create_recomendation(params) do
      conn
      |> put_status(:created)
      |> render("create.json", recomendation: recomendation)
    end
  end
end
