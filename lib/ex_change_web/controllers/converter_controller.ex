defmodule ExChangeWeb.ConverterController do
  use ExChangeWeb, :controller
  alias ExChange.ConversionInfo
  action_fallback(ExChangeWeb.FallbackController)

  def convert(conn, params) do
    with {:ok, %ConversionInfo{} = conversion_info} <- ExChange.convert(params) do
      render(conn, "convert.json", converter: conversion_info)
    end
  end
end
