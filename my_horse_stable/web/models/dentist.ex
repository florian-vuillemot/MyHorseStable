defmodule MyHorseStable.Dentist do
  use MyHorseStable.Web, :model

  schema "dentists" do
    field :nature_of_the_intervention, :string
    field :date, Ecto.DateTime
    field :observations, :string
    belongs_to :payment, MyHorseStable.Payment

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:nature_of_the_intervention, :date, :observations])
    |> validate_required([:nature_of_the_intervention, :date, :observations])
  end
end
