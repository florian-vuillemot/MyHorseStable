defmodule MyHorseStable.PractitionerTest do
  use MyHorseStable.ModelCase

  alias MyHorseStable.Practitioner

  @valid_attrs %{address: "some content", mail: "some content", name: "some content", phone_number: "some content", work_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Practitioner.changeset(%Practitioner{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Practitioner.changeset(%Practitioner{}, @invalid_attrs)
    refute changeset.valid?
  end
end
