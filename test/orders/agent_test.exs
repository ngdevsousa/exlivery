defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent

  import Exlivery.Factory

  describe "save/1" do
    test "it should be able to save an order" do
      OrderAgent.start_link(nil)
      order = build(:order)

      assert {:ok, _id} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(nil)
      order = build(:order)
      {:ok, default_order: order}
    end

    test "it should return an existing order", %{default_order: order} do
      {:ok, id} = OrderAgent.save(order)

      result = OrderAgent.get(id)
      expected_result = {:ok, order}

      assert result == expected_result
    end

    test "it should return an error if the order doesn't exist" do
      result = OrderAgent.get("foo")
      expected_result = {:error, "Order not found"}

      assert result == expected_result
    end
  end
end
