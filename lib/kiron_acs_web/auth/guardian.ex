defmodule KironAcsWeb.Auth.Guardian do
  use Guardian, otp_app: :kiron_acs

  alias KironAcs.{Agent, Pregnant}

  alias KironAcs.Sessions.Get, as: SessionGet

  def subject_for_token(%Agent{id: id}, _claims) do
    sub = %{id: id, type: :agent}
    {:ok, sub}
  end

  def subject_for_token(%Pregnant{id: id}, _claims) do
    sub = %{id: id, type: :pregnant}
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> SessionGet.by_id()
  end

  def authenticate(%{"number_registration" => number_registration}) do
    with {:ok, agent} <-
           SessionGet.by_user({:number_registration, number_registration}),
         {:ok, token, _claims} <- encode_and_sign(agent, %{}, ttl: {15, :hours}) do
      {:ok, token, agent.id}
    else
      error -> error
    end
  end

  def authenticate(%{"cpf" => cpf}) do
    with {:ok, pregnant} <-
           SessionGet.by_user({:cpf, cpf}),
         {:ok, token, _claims} <- encode_and_sign(pregnant, %{}, ttl: {15, :hours}) do
      {:ok, token}
    else
      error -> error
    end
  end

  # TODO
  # Ajustar retorno dos erros
  def authenticate(_), do: {:error, "Invalid or missing params!"}
end
