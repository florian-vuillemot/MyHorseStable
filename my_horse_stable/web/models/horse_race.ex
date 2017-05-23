defmodule MyHorseStable.HorseRace do
  use MyHorseStable.Web, :model

  schema "horse_race" do
    field :name, :string
    field :definition, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :definition])
    |> validate_required([:name, :definition])
  end
end
