defmodule KironAcsWeb.SessionsView do
  use KironAcsWeb, :view

  def render("signin.json", %{data: {token, id}}), do: %{token: token, id: id}
end
