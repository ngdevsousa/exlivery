defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      cpf = "000.000.000-00"
      user = build(:user, cpf: cpf)
      items = build_list(2, :item)

      UserAgent.save(user)

      {:ok, default_cpf: cpf, default_items: items}
    end

    test "it should save a user when valid params are provided", %{default_cpf: cpf, default_items: items} do
      params = %{user_cpf: cpf, items: items}
      result = params |> CreateOrUpdate.call()

      assert {:ok, _id} = result
    end

    test "it should return an error when a invalid cpf is provided", %{default_items: items} do
      params = %{user_cpf: "foo", items: items}
      result = params |> CreateOrUpdate.call()
      expected_result = {:error, "User not found"}

      assert result == expected_result
    end

    test "it should return an error when an invalid item quantity is provided", %{default_cpf: cpf } do
      params = %{user_cpf: cpf, items: build_list(2, :item, quantity: 0)}
      result = params |> CreateOrUpdate.call()
      expected_result = {:error, "Invalid Items!"}

      assert result == expected_result
    end

    test "it should return an error when an empty list is provided", %{default_cpf: cpf } do
      params = %{user_cpf: cpf, items: []}
      result = params |> CreateOrUpdate.call()
      expected_result = {:error, "Invalid params!"}

      assert result == expected_result
    end

  end
end
