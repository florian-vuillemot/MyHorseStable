defmodule MyHorseStable.VeterinaryCareControllerTest do
  use MyHorseStable.ConnCase

  alias MyHorseStable.VeterinaryCare
  @valid_attrs %{date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, date_of_the_sending_the_declaration_of_loss: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, hospitalization: 42, hospitalization_begin: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, hospitalization_end: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, nature_of_care: "some content", nature_of_the_intervention: "some content", observations: "some content", radio: 42, reimbursement_amount: "120.5", reimbursement_date: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, ultrasound: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, veterinary_care_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing veterinarys care"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, veterinary_care_path(conn, :new)
    assert html_response(conn, 200) =~ "New veterinary care"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, veterinary_care_path(conn, :create), veterinary_care: @valid_attrs
    assert redirected_to(conn) == veterinary_care_path(conn, :index)
    assert Repo.get_by(VeterinaryCare, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, veterinary_care_path(conn, :create), veterinary_care: @invalid_attrs
    assert html_response(conn, 200) =~ "New veterinary care"
  end

  test "shows chosen resource", %{conn: conn} do
    veterinary_care = Repo.insert! %VeterinaryCare{}
    conn = get conn, veterinary_care_path(conn, :show, veterinary_care)
    assert html_response(conn, 200) =~ "Show veterinary care"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, veterinary_care_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    veterinary_care = Repo.insert! %VeterinaryCare{}
    conn = get conn, veterinary_care_path(conn, :edit, veterinary_care)
    assert html_response(conn, 200) =~ "Edit veterinary care"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    veterinary_care = Repo.insert! %VeterinaryCare{}
    conn = put conn, veterinary_care_path(conn, :update, veterinary_care), veterinary_care: @valid_attrs
    assert redirected_to(conn) == veterinary_care_path(conn, :show, veterinary_care)
    assert Repo.get_by(VeterinaryCare, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    veterinary_care = Repo.insert! %VeterinaryCare{}
    conn = put conn, veterinary_care_path(conn, :update, veterinary_care), veterinary_care: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit veterinary care"
  end

  test "deletes chosen resource", %{conn: conn} do
    veterinary_care = Repo.insert! %VeterinaryCare{}
    conn = delete conn, veterinary_care_path(conn, :delete, veterinary_care)
    assert redirected_to(conn) == veterinary_care_path(conn, :index)
    refute Repo.get(VeterinaryCare, veterinary_care.id)
  end
end
