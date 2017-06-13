defmodule MyHorseStable.OsteopathController do
  use MyHorseStable.Web, :controller

  alias MyHorseStable.Osteopath
  alias MyHorseStable.Horse
  alias MyHorseStable.Practitioner

  def index(conn, _params) do
    osteopaths = Repo.all(Osteopath)
    render(conn, "index.html", osteopaths: osteopaths)
  end

  def new(conn, _params) do
    changeset = Osteopath.changeset(%Osteopath{})
    render(conn, "new.html", changeset: changeset, horses: get_horses(), practitioner: get_practitioner())
  end

  def create(conn, %{"osteopath" => osteopath_params}) do
    changeset = Osteopath.changeset(%Osteopath{}, osteopath_params)

    case Repo.insert(changeset) do
      {:ok, _osteopath} ->
        conn
        |> put_flash(:info, "Osteopath created successfully.")
        |> redirect(to: appointment_path(conn, :new, %{:horse_id => osteopath_params["horse_id"], :practitioner_id => osteopath_params["practitioner_id"]}))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, horses: get_horses(), practitioner: get_practitioner())
    end
  end

  def show(conn, %{"id" => id}) do
    osteopath = Repo.get!(Osteopath, id)
    render(conn, "show.html", osteopath: osteopath)
  end

  def edit(conn, %{"id" => id}) do
    osteopath = Repo.get!(Osteopath, id)
    changeset = Osteopath.changeset(osteopath)
    render(conn, "edit.html", osteopath: osteopath, changeset: changeset, horses: get_horses(), practitioner: get_practitioner())
  end

  def update(conn, %{"id" => id, "osteopath" => osteopath_params}) do
    osteopath = Repo.get!(Osteopath, id)
    changeset = Osteopath.changeset(osteopath, osteopath_params)

    case Repo.update(changeset) do
      {:ok, osteopath} ->
        conn
        |> put_flash(:info, "Osteopath updated successfully.")
        |> redirect(to: osteopath_path(conn, :show, osteopath))
      {:error, changeset} ->
        render(conn, "edit.html", osteopath: osteopath, changeset: changeset, horses: get_horses(), practitioner: get_practitioner())
    end
  end

  def delete(conn, %{"id" => id}) do
    osteopath = Repo.get!(Osteopath, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(osteopath)

    conn
    |> put_flash(:info, "Osteopath deleted successfully.")
    |> redirect(to: osteopath_path(conn, :index))
  end


  ################################
  @doc """
    Return all horses
  """
  def get_horses() do
    Repo.all(Horse)
  end

  @doc """
      Return dentist practitioner
  """
  def get_practitioner() do
    query = from p in Practitioner,
            where: p.work_name == "Osteopath"
    Repo.all(query)
  end
end
