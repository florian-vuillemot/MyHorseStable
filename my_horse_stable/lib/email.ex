defmodule MyHorseStable.Email do
  use Bamboo.Phoenix, view: MyHorseStable.EmailView

  def welcome_text_email(email_address) do
    new_email
    |> to(email_address)
    |> from("vuillemot.florian@outlook.fr")
    |> subject("Welcome!")
    |> text_body("Welcome to MyApp!")
  end
end
