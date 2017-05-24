defmodule MyHorseStable.Repo.Migrations.AddBirthdayToUsers do
  use Ecto.Migration

  def change do
        alter table(:customers) do
            add :birthday_date, :naive_datetime
        end
  end
end
