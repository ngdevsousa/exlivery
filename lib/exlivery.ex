defmodule Exlivery do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  def start_agents do
    UserAgent.start_link(nil)
  end
  defdelegate create_or_update_user(params), to: CreateOrUpdate, as: :call
end
