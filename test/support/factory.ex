defmodule Exlivery.Factory do
  use ExMachina

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
end
