defmodule MyHorseStable.CustomerTest do
  use MyHorseStable.ModelCase

  alias MyHorseStable.Customer

  @valid_attrs %{email: "some content", first_name: "some content", last_name: "some content", phone_number: "some content", birthday_date: "1995-05-03 00:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Customer.changeset(%Customer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Customer.changeset(%Customer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
