defmodule KironAcsWeb.Auth.Guardian do
  use Guardian, otp_app: :kiron_acs

  alias KironAcs.Agent
  alias KironAcs.Agents.Get, as: AgentGet

  def subject_for_token(%Agent{id: id}, _claims), do: {:ok, id}

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> AgentGet.by_id()
  end

  def authenticate(%{"number_registration" => number_registration}) do
    with {:ok, %Agent{} = agent} <-
           AgentGet.by_number_registration(number_registration),
         {:ok, token, _claims} <- encode_and_sign(agent, %{}, ttl: {15, :hours}) do
      {:ok, token}
    else
      error -> error
    end
  end

  # TODO
  # Ajustar retorno dos erros
  def authenticate(_), do: {:error, "Invalid or missing params!"}
end
