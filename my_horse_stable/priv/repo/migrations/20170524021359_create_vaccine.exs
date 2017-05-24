defmodule MyHorseStable.Repo.Migrations.CreateVaccine do
  use Ecto.Migration

  def change do
    create table(:vaccines) do
      add :date, :datetime
      add :type_of_vaccine, :string
      add :payment_id, references(:payments, on_delete: :nothing)

      timestamps()
    end
    create index(:vaccines, [:payment_id])

  end
end
