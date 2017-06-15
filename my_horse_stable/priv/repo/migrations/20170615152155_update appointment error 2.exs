defmodule :"Elixir.MyHorseStable.Repo.Migrations.Update appointment error 2" do
  use Ecto.Migration

  def change do
    alter table(:appointments) do
      remove :from
      add :from_id, references(:practitioners, on_delete: :nothing)
    end
    create index(:appointments, [:from_id])
  end
end
