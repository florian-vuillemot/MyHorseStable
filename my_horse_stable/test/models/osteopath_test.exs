defmodule MyHorseStable.OsteopathTest do
  use MyHorseStable.ModelCase

  alias MyHorseStable.Osteopath

  @valid_attrs %{date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, nature_of_the_intervention: "some content", observations: "some content", practitioner_id: 1, horse_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Osteopath.changeset(%Osteopath{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Osteopath.changeset(%Osteopath{}, @invalid_attrs)
    refute changeset.valid?
  end
end
