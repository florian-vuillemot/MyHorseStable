defmodule MyHorseStable.ShoeingControllerTest do
  use MyHorseStable.ConnCase

  alias MyHorseStable.Shoeing
  @valid_attrs %{date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, nature_of_the_intervention: "some content", observations: "some content", practitioner_id: 1, horse_id: 1}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, shoeing_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing shoeings"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, shoeing_path(conn, :new)
    assert html_response(conn, 200) =~ "New shoeing"
  end

'''
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, shoeing_path(conn, :create), shoeing: @valid_attrs
    assert redirected_to(conn) == shoeing_path(conn, :index)
    assert Repo.get_by(Shoeing, @valid_attrs)
  end
'''

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, shoeing_path(conn, :create), shoeing: @invalid_attrs
    assert html_response(conn, 200) =~ "New shoeing"
  end

  test "shows chosen resource", %{conn: conn} do
    shoeing = Repo.insert! %Shoeing{}
    conn = get conn, shoeing_path(conn, :show, shoeing)
    assert html_response(conn, 200) =~ "Show shoeing"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, shoeing_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    shoeing = Repo.insert! %Shoeing{}
    conn = get conn, shoeing_path(conn, :edit, shoeing)
    assert html_response(conn, 200) =~ "Edit shoeing"
  end
'''
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    shoeing = Repo.insert! %Shoeing{}
    conn = put conn, shoeing_path(conn, :update, shoeing), shoeing: @valid_attrs
    assert redirected_to(conn) == shoeing_path(conn, :show, shoeing)
    assert Repo.get_by(Shoeing, @valid_attrs)
  end
'''
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    shoeing = Repo.insert! %Shoeing{}
    conn = put conn, shoeing_path(conn, :update, shoeing), shoeing: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit shoeing"
  end

  test "deletes chosen resource", %{conn: conn} do
    shoeing = Repo.insert! %Shoeing{}
    conn = delete conn, shoeing_path(conn, :delete, shoeing)
    assert redirected_to(conn) == shoeing_path(conn, :index)
    refute Repo.get(Shoeing, shoeing.id)
  end
end
