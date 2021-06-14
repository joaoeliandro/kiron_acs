defmodule KironAcs.Repo.Migrations.CreateAgents do
  use Ecto.Migration

  def change do
    create table :agents do
      add :number_cns, :string
      add :number_cbo, :string
      add :number_cnes, :string
      add :number_ine, :string
      add :full_name, :string
      add :email, :string

      timestamps()
    end

    create unique_index(:agents, [:number_cns])
    create unique_index(:agents, [:email])
  end
end
