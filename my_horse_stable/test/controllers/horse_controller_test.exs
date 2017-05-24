defmodule MyHorseStable.HorseControllerTest do
  use MyHorseStable.ConnCase

  alias MyHorseStable.Horse
  @valid_attrs %{birthday_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, name: "some content", nationality: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, horse_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing horses"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, horse_path(conn, :new)
    assert html_response(conn, 200) =~ "New horse"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, horse_path(conn, :create), horse: @valid_attrs
    assert redirected_to(conn) == horse_path(conn, :index)
    assert Repo.get_by(Horse, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, horse_path(conn, :create), horse: @invalid_attrs
    assert html_response(conn, 200) =~ "New horse"
  end

  test "shows chosen resource", %{conn: conn} do
    horse = Repo.insert! %Horse{}
    conn = get conn, horse_path(conn, :show, horse)
    assert html_response(conn, 200) =~ "Show horse"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, horse_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    horse = Repo.insert! %Horse{}
    conn = get conn, horse_path(conn, :edit, horse)
    assert html_response(conn, 200) =~ "Edit horse"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    horse = Repo.insert! %Horse{}
    conn = put conn, horse_path(conn, :update, horse), horse: @valid_attrs
    assert redirected_to(conn) == horse_path(conn, :show, horse)
    assert Repo.get_by(Horse, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    horse = Repo.insert! %Horse{}
    conn = put conn, horse_path(conn, :update, horse), horse: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit horse"
  end

  test "deletes chosen resource", %{conn: conn} do
    horse = Repo.insert! %Horse{}
    conn = delete conn, horse_path(conn, :delete, horse)
    assert redirected_to(conn) == horse_path(conn, :index)
    refute Repo.get(Horse, horse.id)
  end
end
