defmodule MyHorseStable.PageControllerTest do
  use MyHorseStable.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "My Horse Stable"
  end
end
