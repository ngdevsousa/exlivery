defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  def user_factory do
    %User{
      address: "Av. Zero",
      age: 24,
      cpf: "000.000.000-00",
      email: "foo@email.com",
      name: "foo"
    }
  end

  def item_factory do
    %Item{category: :pizza, description: "Pizza G", quantity: 1, unit_price: Decimal.new("22.50")}
  end
end
