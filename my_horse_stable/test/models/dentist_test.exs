defmodule MyHorseStable.DentistTest do
  use MyHorseStable.ModelCase

  alias MyHorseStable.Dentist

  @valid_attrs %{date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, nature_of_the_intervention: "some content", observations: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Dentist.changeset(%Dentist{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Dentist.changeset(%Dentist{}, @invalid_attrs)
    refute changeset.valid?
  end
end
