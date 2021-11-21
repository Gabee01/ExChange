defmodule ExChangeWeb.ConverterView do
  use ExChangeWeb, :view

  def render("convert.json", %{converter: conversion_info}) do
    %{data: render_one(conversion_info, ExChangeWeb.ConverterView, "conversion_info.json")}
  end

  def render("conversion_info.json", %{converter: conversion_info}) do
    %{
      currency: Map.get(conversion_info, :currency),
      amount: Map.get(conversion_info, :amount),
      updated_at: Map.get(conversion_info, :updated_at)
    }
  end
end
