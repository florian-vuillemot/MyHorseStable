defmodule MyHorseStable.OsteopathControllerTest do
  use MyHorseStable.ConnCase

  alias MyHorseStable.Osteopath
  @valid_attrs %{date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, nature_of_the_intervention: "some content", observations: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, osteopath_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing osteopaths"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, osteopath_path(conn, :new)
    assert html_response(conn, 200) =~ "New osteopath"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, osteopath_path(conn, :create), osteopath: @valid_attrs
    assert redirected_to(conn) == osteopath_path(conn, :index)
    assert Repo.get_by(Osteopath, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, osteopath_path(conn, :create), osteopath: @invalid_attrs
    assert html_response(conn, 200) =~ "New osteopath"
  end

  test "shows chosen resource", %{conn: conn} do
    osteopath = Repo.insert! %Osteopath{}
    conn = get conn, osteopath_path(conn, :show, osteopath)
    assert html_response(conn, 200) =~ "Show osteopath"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, osteopath_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    osteopath = Repo.insert! %Osteopath{}
    conn = get conn, osteopath_path(conn, :edit, osteopath)
    assert html_response(conn, 200) =~ "Edit osteopath"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    osteopath = Repo.insert! %Osteopath{}
    conn = put conn, osteopath_path(conn, :update, osteopath), osteopath: @valid_attrs
    assert redirected_to(conn) == osteopath_path(conn, :show, osteopath)
    assert Repo.get_by(Osteopath, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    osteopath = Repo.insert! %Osteopath{}
    conn = put conn, osteopath_path(conn, :update, osteopath), osteopath: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit osteopath"
  end

  test "deletes chosen resource", %{conn: conn} do
    osteopath = Repo.insert! %Osteopath{}
    conn = delete conn, osteopath_path(conn, :delete, osteopath)
    assert redirected_to(conn) == osteopath_path(conn, :index)
    refute Repo.get(Osteopath, osteopath.id)
  end
end
