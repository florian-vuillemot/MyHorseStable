defmodule MyHorseStable.Appointment do
  use MyHorseStable.Web, :model

  schema "appointments" do
    field :name, :string
    field :done, :integer
    field :comment, :string
    field :date_appointment, Ecto.DateTime
    belongs_to :from, MyHorseStable.Practitioner

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :from_id, :done, :comment, :date_appointment])
    |> validate_required([:name, :from_id, :done, :comment, :date_appointment])
  end
end
