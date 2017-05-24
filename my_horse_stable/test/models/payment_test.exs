defmodule MyHorseStable.PaymentTest do
  use MyHorseStable.ModelCase

  alias MyHorseStable.Payment

  @valid_attrs %{date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, libel: "some content", type: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Payment.changeset(%Payment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Payment.changeset(%Payment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
