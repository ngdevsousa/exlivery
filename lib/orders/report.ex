defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.{Item, Order}

  def create(filename \\ "report.csv") do
    orders_list = build_order_list()

    File.write(filename, orders_list)
  end

  defp build_order_list do
    OrderAgent.find_all()
    |> Map.values()
    |> Enum.map(&order_string/1)
  end

  defp order_string(%Order{user_cpf: cpf, items: items, total_price: total}) do
    itens_string = Enum.map(items, &item_to_string/1)
    "#{cpf},#{itens_string},#{total}\n"
  end

  defp item_to_string(%Item{category: category, quantity: quantity, unit_price: unit_price}) do
    "#{category},#{quantity},#{unit_price}"
  end
end
