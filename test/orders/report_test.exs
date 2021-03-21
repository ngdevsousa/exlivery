defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    setup do
      OrderAgent.start_link(nil)

      :ok
    end

    test "it should be able to generate a report file" do
      filename = "report_test.csv"

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      Report.create(filename)
      result = File.read!(filename)

      expected_result =
        "000.000.000-00,pizza,1,22.50pizza,1,22.50,45.00\n" <>
          "000.000.000-00,pizza,1,22.50pizza,1,22.50,45.00\n"

      assert result == expected_result
    end
  end
end
