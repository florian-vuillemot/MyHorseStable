defmodule MyHorseStable.HorseController do
  use MyHorseStable.Web, :controller

  alias MyHorseStable.Horse
  alias MyHorseStable.HorseRace
  alias MyHorseStable.Appointment

  alias MyHorseStable.Dentist
  alias MyHorseStable.Osteopath
  alias MyHorseStable.Shoeing
  alias MyHorseStable.Vaccine
  alias MyHorseStable.VeterinaryCare

  alias MyHorseStable.Practitioner

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
    get_appointments(id)
    horse = Repo.get!(Horse, id)
    render(conn, "show.html", horse: horse, appointments: get_appointments(id), next_appointments: get_futur_appointments_with_name(id))
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

  def get_futur_appointments(horse_id) do
    date = Timex.now |> Ecto.DateTime.cast!
    IO.inspect date
    query = from a in Appointment,
            join: p in assoc(a, :from),
            where: ^date < a.date_appointment or ^date == a.date_appointment,
            select: %{:name => a.name, :date_appointment => a.date_appointment, :from => p.name}
    Repo.all(query)
  end
  @doc """
    Return appointements and add name of practioner in each.
  """
  def get_futur_appointments_with_name(horse_id) do
    get_futur_appointments(horse_id)
    |> Enum.map(fn a -> Map.put(a, :practitioner_name, Repo.get(Practitioner, horse_id).name) end)
  end

  @doc """
    Return list of element in database.
  """
  renvoyer la liste des éléments ayant cette id
  def get_list(type, horse_id) do
    query = from elem in type,
            where: elem.horse == horse_id
    li = Repo.get(query)
    IO.inspect li
    case li do
      nil -> []
      _ -> [li]
    end
  end
  @doc """
    Return list of element in database and set type in each element.
  """
  def get_list_type_practioner(type, horse_id) do
    get_list(type, horse_id)
    |> Enum.map(fn v -> Map.put(v, :type, type) end)
    |> Enum.map(fn v -> Map.put(v, :practitioner_name, Repo.get(Practitioner, v.practitioner_id).name) end)
  end
  @doc """
    Return all appointments
  """
  def get_appointments(horse_id) do
    get_list(Dentist, horse_id)
    |> Enum.concat(get_list_type_practioner(Osteopath, horse_id))
    |> Enum.concat(get_list_type_practioner(Shoeing, horse_id))
    |> Enum.concat(
      get_list_type_practioner(Vaccine, horse_id)
      |> Enum.map(fn v -> Map.put(v, :nature_of_the_intervention, "Vaccine") end)
      )
    |> Enum.concat(get_list_type_practioner(VeterinaryCare, horse_id))
  end
end
