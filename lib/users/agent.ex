defmodule Exlivery.Users.Agent do
  use Agent

  alias Exlivery.Users.User

  def start_link(_initial_state), do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  def save(%User{} = user), do: Agent.update(__MODULE__, &update_state(&1, user))

  def update_state(state, %User{cpf: cpf} = user), do: Map.put(state, cpf, user)

  def get(cpf), do: Agent.get(__MODULE__, &get_by_cpf(&1, cpf))

  defp get_by_cpf(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
