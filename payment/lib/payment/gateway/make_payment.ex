defmodule Payment.Gateway.MakePayment do
  alias Payment.Gateway.Auth

  use Tesla

  #plug Tesla.Middleware.BaseUrl, "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest" 
  plug Tesla.Middleware.Headers, [{"Authorization", "Bearer #{Auth.get_auth_key()}"}]
  plug Tesla.Middleware.JSON

  @spec password :: String.t()
  def password do
    Base.encode64(encode_data())
  end

  @spec encode_data :: String.t()
  def encode_data do
    #access_token = Auth.get_auth_key()
    access_token = "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919"
    "174379#{access_token}#{date_format()}"
  end

  def date_format do
    {:ok, datetime} =  DateTime.now("Africa/Nairobi")
    [head, _tail] =
    datetime
    |> DateTime.to_string()
    |> String.replace("-", "")
    |> String.replace(" ", "")
    |> String.replace(":", "")
    |> String.replace("#DateTime<", "")
    |> String.split(".")
    
  head

  end

  def pay(buy_for, pay_from, amount) do
    payment_details = %{
      BusinessShortCode: 174379,
      Password: password(),
      Timestamp: date_format(),
      TransactionType: "CustomerPayBillOnline",
      Amount: amount,
      PartyA: buy_for,
      PartyB: 174379,
      PhoneNumber: pay_from,
      CallBackURL: "https://mydomain.com/pat",
      AccountReference: "Test",
      TransactionDesc: "Test"
    }

    post("https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest", payment_details)
  end

  
end
