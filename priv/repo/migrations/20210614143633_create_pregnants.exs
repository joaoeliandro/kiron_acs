defmodule KironAcs.Repo.Migrations.CreatePregnants do
  use Ecto.Migration

  def change do
    create table(:pregnants) do
      add :number_cns, :string, size: 15
      add :number_nis, :string, size: 11
      add :cpf, :string, size: 11
      add :family_responsible, :string, null: false
      add :family_responsible_cns, :string
      add :family_responsible_cpf, :string
      add :microarea, :string
      add :full_name, :string, null: false
      add :social_name, :string
      add :birthday, :date, null: false
      add :race_color, :string, null: false
      add :ethnicity, :string
      add :gender, :string
      add :mother_full_name, :string
      add :father_full_name, :string
      add :nationality, :string, null: false
      add :country_birth, :string, null: false
      add :naturalization_date, :date
      add :naturalization_ordinance, :string
      add :city_birth, :string, null: false
      add :checkin_brazil_date, :date
      add :phone, :string
      add :email, :string
      add :agent_id, references(:agents, type: :binary_id), null: false

      timestamps()
    end

    create unique_index(:pregnants, [:cpf])
    create unique_index(:pregnants, [:email])
    create unique_index(:pregnants, [:number_cns])
    create unique_index(:pregnants, [:family_responsible_cns])
    create unique_index(:pregnants, [:family_responsible_cpf])
  end
end
