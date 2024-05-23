defmodule PaymentTest.MakePaymentTest do

  use ExUnit.Case

  setup do

    mock(
      fn
        %{method: :post, url: "https://makepayment"} ->

          %Tesla.Env{status: 200, body: "payment made"}
      end
    )
  end


  test do "testing making stk push " do

    assert {:ok, %Tesla.Env{} = env} = post("https://makepayment")
    assert env.status == 200
    assert env.body == "payment made"
  end

end
