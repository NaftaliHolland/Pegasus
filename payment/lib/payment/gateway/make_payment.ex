defmodule Payment.Gateway.MakePayment do
  alias Payment.Gateway.Auth
    
  use Tesla
  

  plug Tesla.Middleware.BaseUrl, "https://sandbox.safaricom.co.ke/mpesa/stkpushquery/v1/query"
  

  @spec password :: String.t()
  def password do
    Base.encode64(encode_data)
    
  end

  @spec encode_date :: String.t()
  def encode_data do
    %{"access_token" => access_token} = Auth.get_auth_key()
    "174379#{DateTime.utc_now() |> DateTime.to_string()}#{access_token}"

  end

  @spec pay(String.t(), integer) :: any()
  def pay(short_code, amount) do
    
    

  end
end
