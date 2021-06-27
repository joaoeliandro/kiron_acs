defmodule KironAcs.Recomendation do
  use Ecto.Schema
  import Ecto.Changeset

  alias KironAcs.{Agent, Pregnant}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [
    :description,
    :agent_id,
    :pregnant_id
  ]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "recomendations" do
    field :description, :string

    belongs_to :agent, Agent
    belongs_to :pregnant, Pregnant

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
