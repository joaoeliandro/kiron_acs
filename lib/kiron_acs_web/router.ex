defmodule KironAcsWeb.Router do
  use KironAcsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug KironAcsWeb.Auth.Pipeline
  end

  scope "/", KironAcsWeb do
    pipe_through [:api, :auth]

    post "/pregnants", PregnantsController, :create
    get "/pregnants", PregnantsController, :show
    get "/pregnants/all/:agent_id", PregnantsController, :get_all_by_agent_id
    post "/pregnants/help", PregnantsController, :helper_mail
    get "/pregnants/:agent_id", PregnantsController, :get_all_by_situation

    post "/recomendations", RecomendationsController, :create
    get "/recomendations", RecomendationsController, :show
    get "/recomendations/agents/:agent_id", RecomendationsController, :get_all_by_agent_id

    get "/recomendations/pregnants/:pregnant_id",
        RecomendationsController,
        :get_all_by_pregnant_id
  end

  scope "/", KironAcsWeb do
    pipe_through :api

    post "/sessions", SessionsController, :create

    post "/agents", AgentsController, :create
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  # if Mix.env() in [:dev, :test] do
  import Phoenix.LiveDashboard.Router

  scope "/" do
    pipe_through [:fetch_session, :protect_from_forgery]
    live_dashboard "/dashboard", metrics: KironAcsWeb.Telemetry
  end

  # end

  if Mix.env() == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end
end
