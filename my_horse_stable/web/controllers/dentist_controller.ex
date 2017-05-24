defmodule MyHorseStable.DentistController do
  use MyHorseStable.Web, :controller

  alias MyHorseStable.Dentist

  def index(conn, _params) do
    dentists = Repo.all(Dentist)
    render(conn, "index.html", dentists: dentists)
  end

  def new(conn, _params) do
    changeset = Dentist.changeset(%Dentist{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"dentist" => dentist_params}) do
    changeset = Dentist.changeset(%Dentist{}, dentist_params)

    case Repo.insert(changeset) do
      {:ok, _dentist} ->
        conn
        |> put_flash(:info, "Dentist created successfully.")
        |> redirect(to: dentist_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    dentist = Repo.get!(Dentist, id)
    render(conn, "show.html", dentist: dentist)
  end

  def edit(conn, %{"id" => id}) do
    dentist = Repo.get!(Dentist, id)
    changeset = Dentist.changeset(dentist)
    render(conn, "edit.html", dentist: dentist, changeset: changeset)
  end

  def update(conn, %{"id" => id, "dentist" => dentist_params}) do
    dentist = Repo.get!(Dentist, id)
    changeset = Dentist.changeset(dentist, dentist_params)

    case Repo.update(changeset) do
      {:ok, dentist} ->
        conn
        |> put_flash(:info, "Dentist updated successfully.")
        |> redirect(to: dentist_path(conn, :show, dentist))
      {:error, changeset} ->
        render(conn, "edit.html", dentist: dentist, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    dentist = Repo.get!(Dentist, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(dentist)

    conn
    |> put_flash(:info, "Dentist deleted successfully.")
    |> redirect(to: dentist_path(conn, :index))
  end
end
