defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "should return a item, when valid params are provided" do
      result = Item.build("Pizza G", :pizza, "22.50", 1)

      expected_result = {:ok, build(:item)}

      assert result == expected_result
    end

    test "should return an error, when an invalid category is provided" do
      result = Item.build("Pizza G", :foo, "22.50", 1)
      expected_result = {:error, "Invalid params!"}

      assert result == expected_result
    end

    test "should return an error, when an invalid unity_price is provided" do
      result = Item.build("Pizza G", :pizza, "foo", 1)
      expected_result = {:error, "Invalid unity_price!"}

      assert result == expected_result
    end

    test "should return an error, when an invalid quantity is provided" do
      result = Item.build("Pizza G", :pizza, "22.50", 0)
      expected_result = {:error, "Invalid params!"}

      assert result == expected_result
    end
  end
end
