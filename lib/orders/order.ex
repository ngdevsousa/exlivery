defmodule Exlivery.Orders.Order do
  @keys [:user_cpf, :delivery_address, :items, :total_price]
  @enforce_keys @keys

  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  defstruct @keys

  def build(%User{cpf: cpf, address: address}, [%Item{} | _items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       delivery_address: address,
       items: items,
       total_price: calculate_total_price(items)
     }}
  end

  def build(_user, _items), do: {:error, "Invalid params!"}

  defp calculate_total_price(items) do
    items
    |> Enum.reduce(Decimal.new("0.00"), &sum_prices/2)
  end

  defp sum_prices(%Item{unit_price: price, quantity: quantity}, acc) do
    price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end