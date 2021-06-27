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

  def show(conn, _params) do
    task = Task.async(fn -> KironAcs.get_all_recomendations() end)

    with {:ok, recomendations} <- Task.await(task) do
      conn
      |> put_status(:ok)
      |> render("list_recomendations.json", recomendations: recomendations)
    end
  end

  def get_all_by_agent_id(conn, %{"agent_id" => agent_id}) do
    task = Task.async(fn -> KironAcs.get_recomendations_by_agent_id(agent_id) end)

    with {:ok, recomendations} <- Task.await(task) do
      conn
      |> put_status(:ok)
      |> render("list_recomendations_by_agent_id.json", recomendations: recomendations)
    end
  end

  def get_all_by_pregnant_id(conn, %{"pregnant_id" => pregnant_id}) do
    task = Task.async(fn -> KironAcs.get_recomendations_by_pregnant_id(pregnant_id) end)

    with {:ok, recomendations} <- Task.await(task) do
      conn
      |> put_status(:ok)
      |> render("list_recomendations_by_pregnant_id.json", recomendations: recomendations)
    end
  end
end
