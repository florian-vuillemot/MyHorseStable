defmodule MyHorseStable.VeterinaryCareTest do
  use MyHorseStable.ModelCase

  alias MyHorseStable.VeterinaryCare

  @valid_attrs %{date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, date_of_the_sending_the_declaration_of_loss: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, hospitalization: 42, hospitalization_begin: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, hospitalization_end: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, nature_of_care: "some content", nature_of_the_intervention: "some content", observations: "some content", radio: 42, reimbursement_amount: "120.5", reimbursement_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, ultrasound: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = VeterinaryCare.changeset(%VeterinaryCare{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = VeterinaryCare.changeset(%VeterinaryCare{}, @invalid_attrs)
    refute changeset.valid?
  end
end
