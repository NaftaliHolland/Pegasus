defmodule PaymentWeb.PaymentController do
  use PaymentWeb, :controller
  alias Payment.Gateway.MakePayment

  def create(conn, params) do
    %{"buy_for" => buy_for, "pay_from" => pay_from, "amount" => amount} = params
    response = MakePayment.pay(buy_for, pay_from, amount)

    IO.inspect(response)
    conn
    |> put_status(200)
  end
end