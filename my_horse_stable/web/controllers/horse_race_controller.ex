defmodule MyHorseStable.HorseRaceController do
  use MyHorseStable.Web, :controller

  alias MyHorseStable.HorseRace

  def index(conn, _params) do
    horse_race = Repo.all(HorseRace)
    render(conn, "index.html", horse_race: horse_race)
  end

  def new(conn, _params) do
    changeset = HorseRace.changeset(%HorseRace{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"horse_race" => horse_race_params}) do
    changeset = HorseRace.changeset(%HorseRace{}, horse_race_params)

    case Repo.insert(changeset) do
      {:ok, _horse_race} ->
        conn
        |> put_flash(:info, "Horse race created successfully.")
        |> redirect(to: horse_race_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    horse_race = Repo.get!(HorseRace, id)
    render(conn, "show.html", horse_race: horse_race)
  end

  def edit(conn, %{"id" => id}) do
    horse_race = Repo.get!(HorseRace, id)
    changeset = HorseRace.changeset(horse_race)
    render(conn, "edit.html", horse_race: horse_race, changeset: changeset)
  end

  def update(conn, %{"id" => id, "horse_race" => horse_race_params}) do
    horse_race = Repo.get!(HorseRace, id)
    changeset = HorseRace.changeset(horse_race, horse_race_params)

    case Repo.update(changeset) do
      {:ok, horse_race} ->
        conn
        |> put_flash(:info, "Horse race updated successfully.")
        |> redirect(to: horse_race_path(conn, :show, horse_race))
      {:error, changeset} ->
        render(conn, "edit.html", horse_race: horse_race, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    horse_race = Repo.get!(HorseRace, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(horse_race)

    conn
    |> put_flash(:info, "Horse race deleted successfully.")
    |> redirect(to: horse_race_path(conn, :index))
  end
end
