defmodule MyHorseStable.Repo.Migrations.CreateAppointment do
  use Ecto.Migration

  def change do
    create table(:appointments) do
      add :date_day, :datetime
      add :name, :string
      add :from, :string
      add :done, :integer
      add :comment, :string
      add :date_appointment, :datetime

      timestamps()
    end

  end
end
