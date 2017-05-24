defmodule MyHorseStable.PractitionerController do
  use MyHorseStable.Web, :controller

  alias MyHorseStable.Practitioner

  def index(conn, _params) do
    practitioners = Repo.all(Practitioner)
    render(conn, "index.html", practitioners: practitioners)
  end

  def new(conn, _params) do
    changeset = Practitioner.changeset(%Practitioner{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"practitioner" => practitioner_params}) do
    changeset = Practitioner.changeset(%Practitioner{}, practitioner_params)

    case Repo.insert(changeset) do
      {:ok, _practitioner} ->
        conn
        |> put_flash(:info, "Practitioner created successfully.")
        |> redirect(to: practitioner_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    practitioner = Repo.get!(Practitioner, id)
    render(conn, "show.html", practitioner: practitioner)
  end

  def edit(conn, %{"id" => id}) do
    practitioner = Repo.get!(Practitioner, id)
    changeset = Practitioner.changeset(practitioner)
    render(conn, "edit.html", practitioner: practitioner, changeset: changeset)
  end

  def update(conn, %{"id" => id, "practitioner" => practitioner_params}) do
    practitioner = Repo.get!(Practitioner, id)
    changeset = Practitioner.changeset(practitioner, practitioner_params)

    case Repo.update(changeset) do
      {:ok, practitioner} ->
        conn
        |> put_flash(:info, "Practitioner updated successfully.")
        |> redirect(to: practitioner_path(conn, :show, practitioner))
      {:error, changeset} ->
        render(conn, "edit.html", practitioner: practitioner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    practitioner = Repo.get!(Practitioner, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(practitioner)

    conn
    |> put_flash(:info, "Practitioner deleted successfully.")
    |> redirect(to: practitioner_path(conn, :index))
  end
end
