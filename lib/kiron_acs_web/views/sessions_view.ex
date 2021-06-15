defmodule KironAcsWeb.SessionsView do
  use KironAcsWeb, :view

  def render("signin.json", %{token: token}), do: %{token: token}
end
