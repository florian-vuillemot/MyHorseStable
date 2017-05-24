defmodule MyHorseStable.Repo.Migrations.CreateShoeing do
  use Ecto.Migration

  def change do
    create table(:shoeings) do
      add :nature_of_the_intervention, :string
      add :date, :datetime
      add :observations, :string
      add :payment_id, references(:payments, on_delete: :nothing)

      timestamps()
    end
    create index(:shoeings, [:payment_id])

  end
end
