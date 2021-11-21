defmodule ExChangeWeb.ConverterViewTest do
  use ExChangeWeb.ConnCase, async: true
  alias ExChange.ConversionInfo
  alias ExChangeWeb.ConverterView

  describe "render/2" do
    test "renders ConversionInfo" do
      conversion_info = %ConversionInfo{
        amount: 1234.56,
        currency: "BRL",
        updated_at: ~U[2021-11-21 00:00:02Z]
      }

      assert ConverterView.render("convert.json", converter: conversion_info) == %{
               data: %{
                 amount: 1234.56,
                 currency: "BRL",
                 updated_at: ~U[2021-11-21 00:00:02Z]
               }
             }
    end
  end
end
