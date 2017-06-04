defmodule MyHorseStable.VeterinaryCare do
  use MyHorseStable.Web, :model

  schema "veterinarys_care" do
    field :date, Ecto.DateTime
    field :nature_of_the_intervention, :string
    field :observations, :string
    field :nature_of_care, :string
    field :hospitalization, :integer
    field :hospitalization_begin, Ecto.DateTime
    field :hospitalization_end, Ecto.DateTime
    field :radio, :integer
    field :ultrasound, :integer
    field :date_of_the_sending_the_declaration_of_loss, Ecto.DateTime
    field :reimbursement_amount, :float
    field :reimbursement_date, Ecto.DateTime
    belongs_to :horse, MyHorseStable.Horse
    belongs_to :practitioner, MyHorseStable.Practitioner

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:date, :nature_of_the_intervention, :observations, :nature_of_care, :hospitalization, :hospitalization_begin, :hospitalization_end, :radio, :ultrasound, :date_of_the_sending_the_declaration_of_loss, :reimbursement_amount, :reimbursement_date, :horse_id, :practitioner_id])
    |> validate_required([:date, :nature_of_the_intervention, :observations, :nature_of_care, :hospitalization, :hospitalization_begin, :hospitalization_end, :radio, :ultrasound, :date_of_the_sending_the_declaration_of_loss, :reimbursement_amount, :reimbursement_date, :horse_id, :practitioner_id])
  end
end
