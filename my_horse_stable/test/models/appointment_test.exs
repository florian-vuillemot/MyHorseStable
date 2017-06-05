defmodule MyHorseStable.AppointmentTest do
  use MyHorseStable.ModelCase

  alias MyHorseStable.Appointment

  @valid_attrs %{comment: "some content", date_appointment: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, date_day: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, done: 42, from: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Appointment.changeset(%Appointment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Appointment.changeset(%Appointment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
