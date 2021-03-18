defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
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

  def order_factory do
    %Order{
      delivery_address: "Av. Zero",
      items: build_list(2, :item),
      total_price: Decimal.new("45.00"),
      user_cpf: "000.000.000-00"
    }
  end
end
