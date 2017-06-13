defmodule MyHorseStable.ShoeingController do
  use MyHorseStable.Web, :controller

  alias MyHorseStable.Shoeing
  alias MyHorseStable.Horse
  alias MyHorseStable.Practitioner

  def index(conn, _params) do
    shoeings = Repo.all(Shoeing)
    render(conn, "index.html", shoeings: shoeings)
  end

  def new(conn, _params) do
    changeset = Shoeing.changeset(%Shoeing{})
    render(conn, "new.html", changeset: changeset, horses: get_horses(), practitioner: get_practitioner())
  end

  def create(conn, %{"shoeing" => shoeing_params}) do
    changeset = Shoeing.changeset(%Shoeing{}, shoeing_params)

    case Repo.insert(changeset) do
      {:ok, _shoeing} ->
        conn
        |> put_flash(:info, "Shoeing created successfully.")
        |> redirect(to: appointment_path(conn, :new, %{:horse_id => shoeing_params["horse_id"], :practitioner_id => shoeing_params["practitioner_id"]}))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, horses: get_horses(), practitioner: get_practitioner())
    end
  end

  def show(conn, %{"id" => id}) do
    shoeing = Repo.get!(Shoeing, id)
    render(conn, "show.html", shoeing: shoeing)
  end

  def edit(conn, %{"id" => id}) do
    shoeing = Repo.get!(Shoeing, id)
    changeset = Shoeing.changeset(shoeing)
    render(conn, "edit.html", shoeing: shoeing, changeset: changeset, horses: get_horses(), practitioner: get_practitioner())
  end

  def update(conn, %{"id" => id, "shoeing" => shoeing_params}) do
    shoeing = Repo.get!(Shoeing, id)
    changeset = Shoeing.changeset(shoeing, shoeing_params)

    case Repo.update(changeset) do
      {:ok, shoeing} ->
        conn
        |> put_flash(:info, "Shoeing updated successfully.")
        |> redirect(to: shoeing_path(conn, :show, shoeing))
      {:error, changeset} ->
        render(conn, "edit.html", shoeing: shoeing, changeset: changeset, horses: get_horses(), practitioner: get_practitioner())
    end
  end

  def delete(conn, %{"id" => id}) do
    shoeing = Repo.get!(Shoeing, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(shoeing)

    conn
    |> put_flash(:info, "Shoeing deleted successfully.")
    |> redirect(to: shoeing_path(conn, :index))
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
            where: p.work_name == "Shoeing"
    Repo.all(query)
  end
end
