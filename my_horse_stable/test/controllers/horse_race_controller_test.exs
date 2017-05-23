defmodule MyHorseStable.HorseRaceControllerTest do
  use MyHorseStable.ConnCase

  alias MyHorseStable.HorseRace
  @valid_attrs %{definition: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, horse_race_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing horse race"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, horse_race_path(conn, :new)
    assert html_response(conn, 200) =~ "New horse race"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, horse_race_path(conn, :create), horse_race: @valid_attrs
    assert redirected_to(conn) == horse_race_path(conn, :index)
    assert Repo.get_by(HorseRace, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, horse_race_path(conn, :create), horse_race: @invalid_attrs
    assert html_response(conn, 200) =~ "New horse race"
  end

  test "shows chosen resource", %{conn: conn} do
    horse_race = Repo.insert! %HorseRace{}
    conn = get conn, horse_race_path(conn, :show, horse_race)
    assert html_response(conn, 200) =~ "Show horse race"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, horse_race_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    horse_race = Repo.insert! %HorseRace{}
    conn = get conn, horse_race_path(conn, :edit, horse_race)
    assert html_response(conn, 200) =~ "Edit horse race"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    horse_race = Repo.insert! %HorseRace{}
    conn = put conn, horse_race_path(conn, :update, horse_race), horse_race: @valid_attrs
    assert redirected_to(conn) == horse_race_path(conn, :show, horse_race)
    assert Repo.get_by(HorseRace, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    horse_race = Repo.insert! %HorseRace{}
    conn = put conn, horse_race_path(conn, :update, horse_race), horse_race: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit horse race"
  end

  test "deletes chosen resource", %{conn: conn} do
    horse_race = Repo.insert! %HorseRace{}
    conn = delete conn, horse_race_path(conn, :delete, horse_race)
    assert redirected_to(conn) == horse_race_path(conn, :index)
    refute Repo.get(HorseRace, horse_race.id)
  end
end
