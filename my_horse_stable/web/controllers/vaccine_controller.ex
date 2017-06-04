defmodule MyHorseStable.VaccineController do
  use MyHorseStable.Web, :controller

  alias MyHorseStable.Vaccine
  alias MyHorseStable.Horse
  alias MyHorseStable.Practitioner

  def index(conn, _params) do
    vaccines = Repo.all(Vaccine)
    render(conn, "index.html", vaccines: vaccines)
  end

  def new(conn, _params) do
    changeset = Vaccine.changeset(%Vaccine{})
    render(conn, "new.html", changeset: changeset, horses: get_horses(), practitioner: get_practitioner())
  end

  def create(conn, %{"vaccine" => vaccine_params}) do
    changeset = Vaccine.changeset(%Vaccine{}, vaccine_params)

    case Repo.insert(changeset) do
      {:ok, _vaccine} ->
        conn
        |> put_flash(:info, "Vaccine created successfully.")
        |> redirect(to: vaccine_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, horses: get_horses(), practitioner: get_practitioner())
    end
  end

  def show(conn, %{"id" => id}) do
    vaccine = Repo.get!(Vaccine, id)
    render(conn, "show.html", vaccine: vaccine)
  end

  def edit(conn, %{"id" => id}) do
    vaccine = Repo.get!(Vaccine, id)
    changeset = Vaccine.changeset(vaccine)
    render(conn, "edit.html", vaccine: vaccine, changeset: changeset, horses: get_horses(), practitioner: get_practitioner())
  end

  def update(conn, %{"id" => id, "vaccine" => vaccine_params}) do
    vaccine = Repo.get!(Vaccine, id)
    changeset = Vaccine.changeset(vaccine, vaccine_params)

    case Repo.update(changeset) do
      {:ok, vaccine} ->
        conn
        |> put_flash(:info, "Vaccine updated successfully.")
        |> redirect(to: vaccine_path(conn, :show, vaccine))
      {:error, changeset} ->
        render(conn, "edit.html", vaccine: vaccine, changeset: changeset, horses: get_horses(), practitioner: get_practitioner())
    end
  end

  def delete(conn, %{"id" => id}) do
    vaccine = Repo.get!(Vaccine, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(vaccine)

    conn
    |> put_flash(:info, "Vaccine deleted successfully.")
    |> redirect(to: vaccine_path(conn, :index))
  end

    ################################
    @doc """
      Return all horses
    """
    def get_horses() do
      Repo.all(Horse)
    end

    @doc """
        Return veterinary practitioner
    """
    def get_practitioner() do
      query = from p in Practitioner,
              where: p.work_name == "Veterinary"
      Repo.all(query)
    end
end
