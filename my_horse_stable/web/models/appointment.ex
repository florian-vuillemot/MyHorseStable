defmodule MyHorseStable.Appointment do
  use MyHorseStable.Web, :model

  schema "appointments" do
    field :date_day, Ecto.DateTime
    field :name, :string
    field :from, :string
    field :done, :integer
    field :comment, :string
    field :date_appointment, Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:date_day, :name, :from, :done, :comment, :date_appointment])
    |> validate_required([:date_day, :name, :from, :done, :comment, :date_appointment])
  end
end
