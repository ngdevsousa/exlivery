defmodule Exlivery.Orders.Item do
  @categories [:pizza, :pasta]
  @keys [:description, :category, :unit_price, :quantity]
  @enforce_keys @keys

  defstruct @keys

  def build(description, category, unity_price, quantity)
      when quantity > 0 and category in @categories do
    {:ok, %__MODULE__{description: description, category: category, unit_price: unity_price, quantity: quantity}}
  end

  def build(_description, _category, _unity_price, _quantity), do: {:error, "Invalid params!"}
end
