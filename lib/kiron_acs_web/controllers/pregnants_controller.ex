defmodule KironAcsWeb.PregnantsController do
  use KironAcsWeb, :controller

  alias KironAcs.Pregnant

  alias KironAcsWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Pregnant{} = pregnant} <- KironAcs.create_pregnant(params) do
      conn
      |> put_status(:created)
      |> render("create.json", pregnant: pregnant)
    end
  end

  def show(conn, _params) do
    task = Task.async(fn -> KironAcs.get_all_pregnants() end)

    with {:ok, pregnants} <- Task.await(task) do
      conn
      |> put_status(:ok)
      |> render("list_pregnants.json", pregnants: pregnants)
    end
  end

  def get_all_by_agent_id(conn, %{"agent_id" => agent_id}) do
    task = Task.async(fn -> KironAcs.get_pregnants_by_agent_id(agent_id) end)

    with {:ok, pregnants} <- Task.await(task) do
      conn
      |> put_status(:ok)
      |> render("list_pregnants_by_agent_id.json", pregnants: pregnants)
    end
  end
end
