defmodule MyHorseStable.DentistControllerTest do
  use MyHorseStable.ConnCase

  alias MyHorseStable.Dentist

  @valid_attrs %{date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, nature_of_the_intervention: "some content", observations: "some content", practitioner_id: 1, horse_id: 1}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, dentist_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing dentists"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, dentist_path(conn, :new)
    assert html_response(conn, 200) =~ "New dentist"
  end

'''
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, dentist_path(conn, :create), dentist: @valid_attrs
    assert redirected_to(conn) == dentist_path(conn, :index)
    assert Repo.get_by(Dentist, @valid_attrs)
  end
'''

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, dentist_path(conn, :create), dentist: @invalid_attrs
    assert html_response(conn, 200) =~ "New dentist"
  end

  test "shows chosen resource", %{conn: conn} do
    dentist = Repo.insert! %Dentist{}
    conn = get conn, dentist_path(conn, :show, dentist)
    assert html_response(conn, 200) =~ "Show dentist"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, dentist_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    dentist = Repo.insert! %Dentist{}
    conn = get conn, dentist_path(conn, :edit, dentist)
    assert html_response(conn, 200) =~ "Edit dentist"
  end

'''
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    dentist = Repo.insert! %Dentist{}
    conn = put conn, dentist_path(conn, :update, dentist), dentist: @valid_attrs
    assert redirected_to(conn) == dentist_path(conn, :show, dentist)
    assert Repo.get_by(Dentist, @valid_attrs)
  end
'''

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    dentist = Repo.insert! %Dentist{}
    conn = put conn, dentist_path(conn, :update, dentist), dentist: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit dentist"
  end

  test "deletes chosen resource", %{conn: conn} do
    dentist = Repo.insert! %Dentist{}
    conn = delete conn, dentist_path(conn, :delete, dentist)
    assert redirected_to(conn) == dentist_path(conn, :index)
    refute Repo.get(Dentist, dentist.id)
  end
end
