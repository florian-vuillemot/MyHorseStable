defmodule MyHorseStable.HorseController do
  use MyHorseStable.Web, :controller

  alias MyHorseStable.Horse
  alias MyHorseStable.HorseRace

  def index(conn, _params) do
    horses = Repo.all(Horse)
    render(conn, "index.html", horses: horses)
  end

  def new(conn, _params) do
    changeset = Horse.changeset(%Horse{})
    render(conn, "new.html", changeset: changeset, races: get_race())
  end

  def create(conn, %{"horse" => horse_params}) do
    changeset = Horse.changeset(%Horse{}, horse_params)

    case Repo.insert(changeset) do
      {:ok, _horse} ->
        conn
        |> put_flash(:info, "Horse created successfully.")
        |> redirect(to: horse_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, races: get_race())
    end
  end

  def show(conn, %{"id" => id}) do
    horse = Repo.get!(Horse, id)
    render(conn, "show.html", horse: horse)
  end

  def edit(conn, %{"id" => id}) do
    horse = Repo.get!(Horse, id)
    changeset = Horse.changeset(horse)
    render(conn, "edit.html", horse: horse, changeset: changeset, races: get_race())
  end

  def update(conn, %{"id" => id, "horse" => horse_params}) do
    horse = Repo.get!(Horse, id)
    changeset = Horse.changeset(horse, horse_params)

    case Repo.update(changeset) do
      {:ok, horse} ->
        conn
        |> put_flash(:info, "Horse updated successfully.")
        |> redirect(to: horse_path(conn, :show, horse))
      {:error, changeset} ->
        render(conn, "edit.html", horse: horse, changeset: changeset, races: get_race())
    end
  end

  def delete(conn, %{"id" => id}) do
    horse = Repo.get!(Horse, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(horse)

    conn
    |> put_flash(:info, "Horse deleted successfully.")
    |> redirect(to: horse_path(conn, :index))
  end

  ################

  def get_race() do
    Repo.all(HorseRace)
  end
end
