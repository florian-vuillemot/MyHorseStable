defmodule MyHorseStable.PageController do
  use MyHorseStable.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
