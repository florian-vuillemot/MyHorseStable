defmodule MyHorseStable.Repo.Migrations.CreatePayment do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :type, :string
      add :date, :datetime
      add :libel, :string

      timestamps()
    end

  end
end
