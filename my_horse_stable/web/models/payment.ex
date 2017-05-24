defmodule MyHorseStable.Payment do
  use MyHorseStable.Web, :model

  schema "payments" do
    field :type, :string
    field :date, Ecto.DateTime
    field :libel, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:type, :date, :libel])
    |> validate_required([:type, :date, :libel])
  end
end
