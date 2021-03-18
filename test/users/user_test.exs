defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "should return a user, when valid params are provided" do
      result = User.build("foo", "foo@email.com", "000.000.000-00", 24, "Av. Zero")

      expected_result = {:ok, build(:user)}

      assert result == expected_result
    end

    test "should return an error, when age is less than 18" do
      result = User.build("foo", "foo@email.com", "000.000.000-00", 2, "Av. bar")
      expected_result = {:error, "Invalid params!"}

      assert result == expected_result
    end
  end
end
