defmodule MyHorseStable.HorseTest do
  use MyHorseStable.ModelCase

  alias MyHorseStable.Horse

  @valid_attrs %{birthday_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, name: "some content", nationality: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Horse.changeset(%Horse{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Horse.changeset(%Horse{}, @invalid_attrs)
    refute changeset.valid?
  end
end
