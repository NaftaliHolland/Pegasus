defmodule PaymentTest.GatewayTest do
  use ExUnit.Case

  import Tesla.Mock

  setup do
    mock(fn
      %{method: :get, url: "https://auth/generatecode"} ->
        %Tesla.Env{status: 200, body: "unique code"}
    end)

    :ok
  end

  test "testing: generate an auth token" do
    assert {:ok, %Tesla.Env{} = env} = get("https://auth/generatecode")
    assert env.status == 200
    assert env.body == "unique code"
  end
end
