defmodule MyHorseStable.Horse do
  use MyHorseStable.Web, :model

  schema "horses" do
    field :name, :string
    field :birthday_date, Ecto.DateTime
    field :nationality, :string
    belongs_to :race, MyHorseStable.Race

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :birthday_date, :nationality])
    |> validate_required([:name, :birthday_date, :nationality])
  end
end
