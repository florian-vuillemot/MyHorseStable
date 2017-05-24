defmodule MyHorseStable.PractitionerControllerTest do
  use MyHorseStable.ConnCase

  alias MyHorseStable.Practitioner
  @valid_attrs %{address: "some content", mail: "some content", name: "some content", phone_number: "some content", work_name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, practitioner_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing practitioners"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, practitioner_path(conn, :new)
    assert html_response(conn, 200) =~ "New practitioner"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, practitioner_path(conn, :create), practitioner: @valid_attrs
    assert redirected_to(conn) == practitioner_path(conn, :index)
    assert Repo.get_by(Practitioner, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, practitioner_path(conn, :create), practitioner: @invalid_attrs
    assert html_response(conn, 200) =~ "New practitioner"
  end

  test "shows chosen resource", %{conn: conn} do
    practitioner = Repo.insert! %Practitioner{}
    conn = get conn, practitioner_path(conn, :show, practitioner)
    assert html_response(conn, 200) =~ "Show practitioner"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, practitioner_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    practitioner = Repo.insert! %Practitioner{}
    conn = get conn, practitioner_path(conn, :edit, practitioner)
    assert html_response(conn, 200) =~ "Edit practitioner"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    practitioner = Repo.insert! %Practitioner{}
    conn = put conn, practitioner_path(conn, :update, practitioner), practitioner: @valid_attrs
    assert redirected_to(conn) == practitioner_path(conn, :show, practitioner)
    assert Repo.get_by(Practitioner, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    practitioner = Repo.insert! %Practitioner{}
    conn = put conn, practitioner_path(conn, :update, practitioner), practitioner: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit practitioner"
  end

  test "deletes chosen resource", %{conn: conn} do
    practitioner = Repo.insert! %Practitioner{}
    conn = delete conn, practitioner_path(conn, :delete, practitioner)
    assert redirected_to(conn) == practitioner_path(conn, :index)
    refute Repo.get(Practitioner, practitioner.id)
  end
end
