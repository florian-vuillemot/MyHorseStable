defmodule MyHorseStable.VaccineControllerTest do
  use MyHorseStable.ConnCase

  alias MyHorseStable.Vaccine
  @valid_attrs %{date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, type_of_vaccine: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, vaccine_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing vaccines"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, vaccine_path(conn, :new)
    assert html_response(conn, 200) =~ "New vaccine"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, vaccine_path(conn, :create), vaccine: @valid_attrs
    assert redirected_to(conn) == vaccine_path(conn, :index)
    assert Repo.get_by(Vaccine, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, vaccine_path(conn, :create), vaccine: @invalid_attrs
    assert html_response(conn, 200) =~ "New vaccine"
  end

  test "shows chosen resource", %{conn: conn} do
    vaccine = Repo.insert! %Vaccine{}
    conn = get conn, vaccine_path(conn, :show, vaccine)
    assert html_response(conn, 200) =~ "Show vaccine"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, vaccine_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    vaccine = Repo.insert! %Vaccine{}
    conn = get conn, vaccine_path(conn, :edit, vaccine)
    assert html_response(conn, 200) =~ "Edit vaccine"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    vaccine = Repo.insert! %Vaccine{}
    conn = put conn, vaccine_path(conn, :update, vaccine), vaccine: @valid_attrs
    assert redirected_to(conn) == vaccine_path(conn, :show, vaccine)
    assert Repo.get_by(Vaccine, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    vaccine = Repo.insert! %Vaccine{}
    conn = put conn, vaccine_path(conn, :update, vaccine), vaccine: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit vaccine"
  end

  test "deletes chosen resource", %{conn: conn} do
    vaccine = Repo.insert! %Vaccine{}
    conn = delete conn, vaccine_path(conn, :delete, vaccine)
    assert redirected_to(conn) == vaccine_path(conn, :index)
    refute Repo.get(Vaccine, vaccine.id)
  end
end
