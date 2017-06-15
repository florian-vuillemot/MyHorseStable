defmodule :"Elixir.MyHorseStable.Repo.Migrations.Update appointment error" do
  use Ecto.Migration

  def change do
    alter table(:appointments) do
      remove :from
      add :from, references(:practitioners, on_delete: :nothing)
    end
    create index(:appointments, [:from])
  end
end
