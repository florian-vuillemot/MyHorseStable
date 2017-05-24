defmodule MyHorseStable.Repo.Migrations.CreateHorse do
  use Ecto.Migration

  def change do
    create table(:horses) do
      add :name, :string
      add :birthday_date, :datetime
      add :nationality, :string
      add :race_id, references(:horse_race, on_delete: :nothing)

      timestamps()
    end
    create index(:horses, [:race_id])

  end
end
