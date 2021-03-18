defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "build/2" do
    test "should return an order, when valid params are provided" do
      result = Order.build(build(:user), build_list(2, :item))

      expected_result = {:ok, build(:order)}

      assert result == expected_result
    end

    test "should return an error, when zero items are provided" do
      result = Order.build(build(:user), [])
      expected_result = {:error, "Invalid params!"}

      assert result == expected_result
    end
  end
end
