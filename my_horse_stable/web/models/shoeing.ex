defmodule MyHorseStable.Shoeing do
  use MyHorseStable.Web, :model

  schema "shoeings" do
    field :nature_of_the_intervention, :string
    field :date, Ecto.DateTime
    field :observations, :string
    belongs_to :payment, MyHorseStable.Payment
    belongs_to :horse, MyHorseStable.Horse
    belongs_to :practitioner, MyHorseStable.Practitioner

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:nature_of_the_intervention, :date, :observations, :horse_id, :practitioner_id])
    |> validate_required([:nature_of_the_intervention, :date, :observations, :horse_id, :practitioner_id])
  end
end
