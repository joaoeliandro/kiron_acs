defmodule KironAcsWeb.AgentsController do
  use KironAcsWeb, :controller

  alias KironAcs.Agent

  alias KironAcsWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Agent{} = agent} <- KironAcs.create_agent(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(agent) do
      conn
      |> put_status(:created)
      |> render("create.json", token: token, agent: agent)
    end
  end
end
