defmodule KironAcs.Agent do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  # @foreign_key_type :binary_id

  @required_params [
    :number_cns,
    :number_cbo,
    :number_cnes,
    :number_ine,
    :full_name,
    :email
  ]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "agents" do
    field :full_name, :string
    field :email, :string
    field :number_cbo, :string
    field :number_cnes, :string
    field :number_cns, :string
    field :number_ine, :string

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:number_cbo, is: 6)
    |> validate_length(:number_cnes, is: 7)
    |> validate_length(:number_ine, is: 10)
    |> validate_length(:number_cns, is: 15)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:number_cns)
    |> unique_constraint(:email)
  end
end
