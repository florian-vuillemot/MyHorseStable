defmodule MyHorseStable.Repo.Migrations.CreateVeterinaryCare do
  use Ecto.Migration

  def change do
    create table(:veterinarys_care) do
      add :date, :datetime
      add :nature_of_the_intervention, :string
      add :observations, :string
      add :nature_of_care, :string
      add :hospitalization, :integer
      add :hospitalization_begin, :datetime
      add :hospitalization_end, :datetime
      add :radio, :integer
      add :ultrasound, :integer
      add :date_of_the_sending_the_declaration_of_loss, :datetime
      add :reimbursement_amount, :float
      add :reimbursement_date, :datetime

      timestamps()
    end

  end
end
