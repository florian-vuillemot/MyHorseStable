defmodule MyHorseStable.Vaccine do
  use MyHorseStable.Web, :model

  schema "vaccines" do
    field :date, Ecto.DateTime
    field :type_of_vaccine, :string
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
    |> cast(params, [:date, :type_of_vaccine, :horse_id, :practitioner_id])
    |> validate_required([:date, :type_of_vaccine, :horse_id, :practitioner_id])
  end
end
