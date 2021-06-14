defmodule KironAcsWeb.AgentsController do
  use KironAcsWeb, :controller

  alias KironAcs.Agent

  alias KironAcsWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Agent{} = agent} <- KironAcs.create_agent(params) do
      conn
      |> put_status(:created)
      |> render("create.json", agent: agent)
    end
  end
end
