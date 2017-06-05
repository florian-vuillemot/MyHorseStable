defmodule MyHorseStable.AppointmentControllerTest do
  use MyHorseStable.ConnCase

  alias MyHorseStable.Appointment
  @valid_attrs %{comment: "some content", date_appointment: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, date_day: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, done: 42, from: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, appointment_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing appointments"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, appointment_path(conn, :new)
    assert html_response(conn, 200) =~ "New appointment"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, appointment_path(conn, :create), appointment: @valid_attrs
    assert redirected_to(conn) == appointment_path(conn, :index)
    assert Repo.get_by(Appointment, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, appointment_path(conn, :create), appointment: @invalid_attrs
    assert html_response(conn, 200) =~ "New appointment"
  end

  test "shows chosen resource", %{conn: conn} do
    appointment = Repo.insert! %Appointment{}
    conn = get conn, appointment_path(conn, :show, appointment)
    assert html_response(conn, 200) =~ "Show appointment"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, appointment_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    appointment = Repo.insert! %Appointment{}
    conn = get conn, appointment_path(conn, :edit, appointment)
    assert html_response(conn, 200) =~ "Edit appointment"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    appointment = Repo.insert! %Appointment{}
    conn = put conn, appointment_path(conn, :update, appointment), appointment: @valid_attrs
    assert redirected_to(conn) == appointment_path(conn, :show, appointment)
    assert Repo.get_by(Appointment, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    appointment = Repo.insert! %Appointment{}
    conn = put conn, appointment_path(conn, :update, appointment), appointment: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit appointment"
  end

  test "deletes chosen resource", %{conn: conn} do
    appointment = Repo.insert! %Appointment{}
    conn = delete conn, appointment_path(conn, :delete, appointment)
    assert redirected_to(conn) == appointment_path(conn, :index)
    refute Repo.get(Appointment, appointment.id)
  end
end
