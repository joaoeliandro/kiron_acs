defmodule KironAcsWeb.SessionsController do
  use KironAcsWeb, :controller

  alias KironAcsWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, token, id} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("signin.json", data: {token, id})
    end
  end
end
