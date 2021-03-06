defmodule MyHorseStable.VaccineTest do
  use MyHorseStable.ModelCase

  alias MyHorseStable.Vaccine

  @valid_attrs %{date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, type_of_vaccine: "some content", practitioner_id: 1, horse_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Vaccine.changeset(%Vaccine{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Vaccine.changeset(%Vaccine{}, @invalid_attrs)
    refute changeset.valid?
  end
end
