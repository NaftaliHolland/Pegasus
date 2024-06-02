defmodule PaymentWeb.PaymentController do
  use PaymentWeb, :controller
  alias Payment.Gateway.MakePayment

  def create(conn, params) do
    %{"callback_url" => callback_url,"buy_for" => buy_for, "pay_from" => pay_from, "amount" => amount} = params
    {:ok, body} = MakePayment.pay(buy_for, pay_from, amount)

    {:ok, response} = Jason.encode(body.body)

    conn
    |> send_resp(body.status, response)
  end

  def callback(conn, params) do
    IO.puts("this is the response callback")
    IO.inspect(params)
    {:ok, response} = Jason.encode(params["Body"]["stkCallback"])
    IO.inspect(response)

    conn
    |> send_resp(200, response)
  end
end
