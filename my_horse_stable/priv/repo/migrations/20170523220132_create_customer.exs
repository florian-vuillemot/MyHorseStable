defmodule MyHorseStable.Repo.Migrations.CreateCustomer do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :last_name, :string
      add :first_name, :string
      add :email, :string
      add :phone_number, :string

      timestamps()
    end

  end
end
