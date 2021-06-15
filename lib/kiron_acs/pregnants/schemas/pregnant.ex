defmodule KironAcs.Pregnant do
  use Ecto.Schema
  import Ecto.Changeset

  alias KironAcs.Agent

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [
    :full_name,
    :birthday,
    :race_color,
    :nationality,
    :country_birth,
    :city_birth,
    :agent_id
  ]

  @params [
    :number_cns,
    :number_nis,
    :cpf,
    :family_responsible,
    :family_responsible_cns,
    :family_responsible_cpf,
    :microarea,
    :full_name,
    :birthday,
    :race_color,
    :ethnicity,
    :gender,
    :mother_full_name,
    :father_full_name,
    :nationality,
    :country_birth,
    :naturalization_date,
    :naturalization_ordinance,
    :city_birth,
    :checkin_brazil_date,
    :phone,
    :email,
    :agent_id
  ]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "pregnants" do
    field :birthday, :date
    field :checkin_brazil_date, :date
    field :city_birth, :string
    field :country_birth, :string
    field :cpf, :string
    field :email, :string
    field :ethnicity, :string
    field :family_responsible, :string
    field :family_responsible_cns, :string
    field :family_responsible_cpf, :string
    field :father_full_name, :string
    field :full_name, :string
    field :social_name, :string
    field :gender, :string
    field :microarea, :string
    field :mother_full_name, :string
    field :nationality, :string
    field :naturalization_date, :date
    field :naturalization_ordinance, :string
    field :number_cns, :string
    field :number_nis, :string
    field :phone, :string
    field :race_color, :string

    belongs_to :agent, Agent

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @params)
    |> validate_required(@required_params)
    |> validate_length(:number_cns, is: 15)
    |> validate_length(:number_nis, is: 11)
    |> validate_length(:cpf, is: 11)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:cpf)
    |> unique_constraint(:email)
    |> unique_constraint(:number_cns)
    |> unique_constraint(:family_responsible_cns)
    |> unique_constraint(:family_responsible_cpf)
  end
end
