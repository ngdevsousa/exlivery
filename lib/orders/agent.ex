defmodule Exlivery.Orders.Agent do
  use Agent

  alias Exlivery.Orders.Order

  def start_link(_initial_state), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%Order{} = order) do
    uuid = UUID.uuid4()
    Agent.update(__MODULE__, &update_state(&1, order, uuid))

    {:ok, uuid}
  end

  def update_state(state, %Order{} = order, uuid), do: Map.put(state, uuid, order)

  def get(id), do: Agent.get(__MODULE__, &get_by_id(&1, id))

  defp get_by_id(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Order not found"}
      order -> {:ok, order}
    end
  end
end
