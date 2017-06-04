defmodule MyHorseStable.ShoeingTest do
  use MyHorseStable.ModelCase

  alias MyHorseStable.Shoeing

  @valid_attrs %{date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, nature_of_the_intervention: "some content", observations: "some content", practitioner_id: 1, horse_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Shoeing.changeset(%Shoeing{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Shoeing.changeset(%Shoeing{}, @invalid_attrs)
    refute changeset.valid?
  end
end
