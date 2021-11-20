defmodule ExChangeWeb.ConverterController do
  use ExChangeWeb, :controller
  action_fallback(ExChangeWeb.FallbackController)

  def index(conn, params) do
    with {:ok, conversion_info} <- ExChange.convert(params) do
      json(conn, %{conversion_info: conversion_info})
    end
  end
end
