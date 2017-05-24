defmodule MyHorseStable.Practitioner do
  use MyHorseStable.Web, :model

  schema "practitioners" do
    field :name, :string
    field :address, :string
    field :phone_number, :string
    field :mail, :string
    field :work_name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :address, :phone_number, :mail, :work_name])
    |> validate_required([:name, :address, :phone_number, :mail, :work_name])
  end
end
