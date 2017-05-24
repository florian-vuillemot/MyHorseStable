defmodule MyHorseStable.Customer do
  use MyHorseStable.Web, :model

  schema "customers" do
    field :last_name, :string
    field :first_name, :string
    field :email, :string
    field :phone_number, :string
    field :birthday_date, :naive_datetime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:last_name, :first_name, :email, :phone_number, :birthday_date])
    |> validate_required([:last_name, :first_name, :email, :phone_number, :birthday_date])
  end
end
