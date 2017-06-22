defmodule MyHorseStable.AppointmentController do
  use MyHorseStable.Web, :controller

  alias MyHorseStable.Appointment
  alias MyHorseStable.Horse
  alias MyHorseStable.Practitioner

  def index(conn, _params) do
    appointments = Repo.all(Appointment) |> appointment_with_practitioner
    render(conn, "index.html", appointments: appointments)
  end

  def new(conn, params) do
    appointment =
    case params do
      %{"horse_id" => _, "practitioner_id" => _} ->
        %Appointment{
          :name => "Appointment for #{Repo.get!(Horse, params["horse_id"]).name}",
          :from => params["practitioner_id"]
        }
      _ -> %Appointment{}
    end

    changeset = Appointment.changeset(appointment)
    render(conn, "new.html", changeset: changeset, practitioner: get_practitioner(), practitioner_id: params["practitioner_id"])
  end

  def create(conn, %{"appointment" => appointment_params}) do
    changeset = Appointment.changeset(%Appointment{}, appointment_params)

    case Repo.insert(changeset) do
      {:ok, _appointment} ->
        conn
        |> put_flash(:info, "Appointment created successfully.")
        |> redirect(to: appointment_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, practitioner: get_practitioner(), practitioner_id: appointment_params["from"])
    end
  end

  def show(conn, %{"id" => id}) do
    appointment = Repo.get!(Appointment, id) |> appointment_with_practitioner
    render(conn, "show.html", appointment: appointment)
  end

  def edit(conn, %{"id" => id}) do
    appointment = Repo.get!(Appointment, id)
    changeset = Appointment.changeset(appointment)
    render(conn, "edit.html", appointment: appointment, changeset: changeset, practitioner: get_practitioner(), practitioner_id: appointment.from_id)
  end

  def update(conn, %{"id" => id, "appointment" => appointment_params}) do
    appointment = Repo.get!(Appointment, id)
    changeset = Appointment.changeset(appointment, appointment_params)

    case Repo.update(changeset) do
      {:ok, appointment} ->
        conn
        |> put_flash(:info, "Appointment updated successfully.")
        |> redirect(to: appointment_path(conn, :show, appointment))
      {:error, changeset} ->
        render(conn, "edit.html", appointment: appointment, changeset: changeset, practitioner: get_practitioner(), practitioner_id: appointment.from)
    end
  end

  def delete(conn, %{"id" => id}) do
    appointment = Repo.get!(Appointment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(appointment)

    conn
    |> put_flash(:info, "Appointment deleted successfully.")
    |> redirect(to: appointment_path(conn, :index))
  end

  ################################

  @doc """
      Return all practitioner
  """
  def get_practitioner() do
    Repo.all(Practitioner)
  end

  @doc """
    Return a practitioner name
  """
  def get_practitioner_name(appointment) do
    Repo.get!(Practitioner, appointment.from_id).name
  end

  @doc """
    Return appointment(s) with name(s) of practitioner(s)
  """
  def appointment_with_practitioner(appointment) do
    cond do
      is_list(appointment) ->
        appointment |> Enum.map(fn p -> %{p | from: get_practitioner_name(p)} end)
      true ->
        %{appointment | from: get_practitioner_name(appointment)}
    end
  end
end
