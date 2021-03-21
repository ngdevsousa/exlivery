defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  describe "save/1" do
    test "it should be able to save a user" do
      UserAgent.start_link(nil)
      user = build(:user)

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(nil)

      {:ok, default_cpf: "000.000.000-00"}
    end

    test "it should return an existing user", %{default_cpf: cpf} do
      :user
      |> build(cpf: cpf)
      |> UserAgent.save()

      result = UserAgent.get(cpf)

      expected_result =
        {:ok,
         %Exlivery.Users.User{
           address: "Av. Zero",
           age: 24,
           cpf: "000.000.000-00",
           email: "foo@email.com",
           name: "foo"
         }}

      assert result == expected_result
    end

    test "it should return an error if the user doesn't exist" do
      result = UserAgent.get("foo")
      expected_result = {:error, "User not found"}

      assert result == expected_result
    end
  end
end
