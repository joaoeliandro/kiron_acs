defmodule KironAcs.Repo.Migrations.CreateRecomendations do
  use Ecto.Migration

  def change do
    create table(:recomendations) do
      add :description, :string
      add :agent_id, references(:agents, type: :binary_id), null: false
      add :pregnant_id, references(:pregnants, type: :binary_id), null: false

      timestamps()
    end

  end
end
