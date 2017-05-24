defmodule MyHorseStable.VeterinaryCareController do
  use MyHorseStable.Web, :controller

  alias MyHorseStable.VeterinaryCare

  def index(conn, _params) do
    veterinarys_care = Repo.all(VeterinaryCare)
    render(conn, "index.html", veterinarys_care: veterinarys_care)
  end

  def new(conn, _params) do
    changeset = VeterinaryCare.changeset(%VeterinaryCare{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"veterinary_care" => veterinary_care_params}) do
    changeset = VeterinaryCare.changeset(%VeterinaryCare{}, veterinary_care_params)

    case Repo.insert(changeset) do
      {:ok, _veterinary_care} ->
        conn
        |> put_flash(:info, "Veterinary care created successfully.")
        |> redirect(to: veterinary_care_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    veterinary_care = Repo.get!(VeterinaryCare, id)
    render(conn, "show.html", veterinary_care: veterinary_care)
  end

  def edit(conn, %{"id" => id}) do
    veterinary_care = Repo.get!(VeterinaryCare, id)
    changeset = VeterinaryCare.changeset(veterinary_care)
    render(conn, "edit.html", veterinary_care: veterinary_care, changeset: changeset)
  end

  def update(conn, %{"id" => id, "veterinary_care" => veterinary_care_params}) do
    veterinary_care = Repo.get!(VeterinaryCare, id)
    changeset = VeterinaryCare.changeset(veterinary_care, veterinary_care_params)

    case Repo.update(changeset) do
      {:ok, veterinary_care} ->
        conn
        |> put_flash(:info, "Veterinary care updated successfully.")
        |> redirect(to: veterinary_care_path(conn, :show, veterinary_care))
      {:error, changeset} ->
        render(conn, "edit.html", veterinary_care: veterinary_care, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    veterinary_care = Repo.get!(VeterinaryCare, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(veterinary_care)

    conn
    |> put_flash(:info, "Veterinary care deleted successfully.")
    |> redirect(to: veterinary_care_path(conn, :index))
  end
end
