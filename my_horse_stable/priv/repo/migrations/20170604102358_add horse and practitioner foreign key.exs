defmodule :"Elixir.MyHorseStable.Repo.Migrations.Add horse and practitioner foreign key" do
  use Ecto.Migration

  def change do
    alter table(:osteopaths) do
        add :horse_id, references(:horses, on_delete: :nothing)
        add :practitioner_id, references(:practitioners, on_delete: :nothing)
    end
    alter table(:vaccines) do
        add :horse_id, references(:horses, on_delete: :nothing)
        add :practitioner_id, references(:practitioners, on_delete: :nothing)
    end
    alter table(:shoeings) do
        add :horse_id, references(:horses, on_delete: :nothing)
        add :practitioner_id, references(:practitioners, on_delete: :nothing)
    end
    alter table(:veterinarys_care) do
        add :horse_id, references(:horses, on_delete: :nothing)
        add :practitioner_id, references(:practitioners, on_delete: :nothing)
    end
    alter table(:dentists) do
        add :horse_id, references(:horses, on_delete: :nothing)
        add :practitioner_id, references(:practitioners, on_delete: :nothing)
    end
  end
end
