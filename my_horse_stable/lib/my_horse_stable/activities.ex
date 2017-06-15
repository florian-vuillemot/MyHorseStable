defmodule MyHorseStable.Activities do
  use GenServer

  import Ecto.Query

  alias MyHorseStable.Repo
  alias MyHorseStable.Mailer
  alias MyHorseStable.Email
  alias MyHorseStable.Appointment

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work() # Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Do the work you desire here
    schedule_work() # Reschedule once more
    {:noreply, state}
  end

  @doc """
    Send a email with appointment of week if we are on sunday.
    Send email arount 4am (utc).
  """
  def schedule_work() do
    day = Date.utc_today |> Date.day_of_week
    
    if day == 4 do
      {h, _, _} = Time.utc_now  |> Time.to_erl

      if h != 4 do
        date = Timex.now |> Ecto.DateTime.cast!
        date_in_one_week = Timex.add(Timex.now, Timex.Duration.from_days(8)) |> Ecto.DateTime.cast!

        appointments = appointments_between(date, date_in_one_week)
        ### Add get all user and emails
        Email.appointments_html_week("florian.vuillemot@epitech.eu", appointments) |> Mailer.deliver_later # |> IO.inspect Mailer.deliver_now
        Process.send_after(self(), :work, 60 * 1000 * 60 * 24 * 6) # 6 days
    
    ## Wait, goal is to enter in condition and wait a 6 days itch time (6 days because a completetly week can create a decal with time)
      else
        Process.send_after(self(), :work, 10000 * 60) # One minute
      end
    else
      Process.send_after(self(), :work, 60 * 1000 * 60 * 8) # 8 hours
    end
  end

  def appointments_between(date_start, date_end) do
    query = from a in Appointment,
            join: p in assoc(a, :from),
            where: ^date_start < a.date_appointment and ^date_end > a.date_appointment,
            select: %{:name => a.name, :date_appointment => a.date_appointment, :comment => a.comment, :from => p.name}
    Repo.all(query)
  end
end