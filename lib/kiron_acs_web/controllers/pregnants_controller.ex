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

  def get_all_by_agent_id(conn, %{"agent_id" => agent_id}) do
    with pregnants <- KironAcs.get_pregnants_by_agent_id(agent_id) do
      conn
      |> put_status(:ok)
      |> render("list_pregnants_by_agent_id.json", pregnants: pregnants)
    end
  end
end
