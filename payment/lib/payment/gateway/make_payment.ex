defmodule Payment.Gateway.MakePayment do
  alias Payment.Gateway.Auth

  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest" 
  plug Tesla.Middleware.Headers, [{"authorization", "Bearer #{Auth.get_auth_key()}"}]
  plug Tesla.Middleware.JSON

  @spec password :: String.t()
  def password do
    Base.encode64(encode_data())
  end

  @spec encode_data :: String.t()
  def encode_data do
    access_token = Auth.get_auth_key()
    "174379#{date_format()}#{access_token}"
  end

  def date_format do
    DateTime.utc_now()
    |> DateTime.to_string()
    |> String.replace("-", "")
    |> String.replace(" ", "")
    |> String.replace(":", "")
    |> String.replace(".", "")
    |> String.replace("Z", "")
  end

  def pay(buy_for, pay_from, amount) do
    payment_details = %{
      BusinessShortCode: "174379",
      Password: password(),
      Timestamp: date_format(),
      TransactionType: "CustomerPayBillOnline",
      Amount: amount,
      PartyA: buy_for,
      PartyB: "174379",
      PhoneNumber: pay_from,
      CallBackURL: "https://mydomain.com/pat",
      AccountReference: "Test",
      TransactionDesc: "Test"
    }

    post("/", payment_details)
  end

  
end
