defmodule MyHorseStable.Repo.Migrations.CreateHorseRace do
  use Ecto.Migration

  def change do
    create table(:horse_race) do
      add :name, :string
      add :definition, :string

      timestamps()
    end

  end
end
