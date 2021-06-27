defmodule KironAcs.Repo.Migrations.AddSituationMonthColumnPregnants do
  use Ecto.Migration

  def change do
    alter table :pregnants do
      add :prenatal, :boolean
      add :postpartum, :boolean
      add :period_month, :integer
    end

    create constraint(:pregnants, :period_month_must_be_positive, check: "period_month > 0")
  end
end
