defmodule MyHorseStable.Email do
  use Bamboo.Phoenix, view: MyHorseStable.EmailView

#########################################
  @doc """
    Create a email to inform appointements presences.
  """
  def appointments_text_week(email_address) do
    new_email()
    |> to(email_address)
    |> from("vuillemot.florian@outlook.fr")
    |> subject("Appointments on My Hourse Stable!")
    |> put_text_layout({MyHorseStable.LayoutView, "email.text"})
    |> render("activities.text")
  end

  @doc """
    Create html email for print list of appointements.
  """
  def appointments_html_week(email_address, appointments) do
    email_address
    |> appointments_text_week()
    |> put_html_layout({MyHorseStable.LayoutView, "email.html"})
    |> render("activities.html", appointments: appointments)
  end

#########################################
  @doc """
    Text email for say welcome user
  """
  def welcome_text_email(email_address) do
    new_email()
    |> to(email_address)
    |> from("vuillemot.florian@outlook.fr")
    |> subject("Welcome in My Hourse Stable!")
    |> put_text_layout({MyHorseStable.LayoutView, "email.text"})
    |> render("welcome.text")
  end

  @doc """
    Html email for say welcome to user
  """
  def welcome_html_email(conn, email_address) do
    email_address
    |> welcome_text_email()
    |> put_html_layout({MyHorseStable.LayoutView, "email.html"})
    |> render("welcome.html", conn: conn)
  end
end
