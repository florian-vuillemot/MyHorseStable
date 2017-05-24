defmodule MyHorseStable.Repo.Migrations.CreatePractitioner do
  use Ecto.Migration

  def change do
    create table(:practitioners) do
      add :name, :string
      add :address, :string
      add :phone_number, :string
      add :mail, :string
      add :work_name, :string

      timestamps()
    end

  end
end
