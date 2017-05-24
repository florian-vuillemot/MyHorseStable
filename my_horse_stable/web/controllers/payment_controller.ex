defmodule MyHorseStable.PaymentController do
  use MyHorseStable.Web, :controller

  alias MyHorseStable.Payment

  def index(conn, _params) do
    payments = Repo.all(Payment)
    render(conn, "index.html", payments: payments)
  end

  def new(conn, _params) do
    changeset = Payment.changeset(%Payment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"payment" => payment_params}) do
    changeset = Payment.changeset(%Payment{}, payment_params)

    case Repo.insert(changeset) do
      {:ok, _payment} ->
        conn
        |> put_flash(:info, "Payment created successfully.")
        |> redirect(to: payment_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    payment = Repo.get!(Payment, id)
    render(conn, "show.html", payment: payment)
  end

  def edit(conn, %{"id" => id}) do
    payment = Repo.get!(Payment, id)
    changeset = Payment.changeset(payment)
    render(conn, "edit.html", payment: payment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "payment" => payment_params}) do
    payment = Repo.get!(Payment, id)
    changeset = Payment.changeset(payment, payment_params)

    case Repo.update(changeset) do
      {:ok, payment} ->
        conn
        |> put_flash(:info, "Payment updated successfully.")
        |> redirect(to: payment_path(conn, :show, payment))
      {:error, changeset} ->
        render(conn, "edit.html", payment: payment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    payment = Repo.get!(Payment, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(payment)

    conn
    |> put_flash(:info, "Payment deleted successfully.")
    |> redirect(to: payment_path(conn, :index))
  end
end
