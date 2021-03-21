defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  import Exlivery.Factory

  describe "call/1" do
    setup do
      UserAgent.start_link(nil)

      params = build(:user_params)

      {:ok, default_params: params}
    end

    test "it should save a user when valid params are provided", %{default_params: params} do
      result = params |> CreateOrUpdate.call()
      expected_result = {:ok, "Success"}

      assert result == expected_result
    end

    test "it should return an error when invalid params are provided", %{default_params: params} do
      params = Map.put(params, :age, 1)

      result = params |> CreateOrUpdate.call()
      expected_result = {:error, "Invalid params!"}

      assert result == expected_result
    end
  end
end
