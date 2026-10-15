defmodule Cotizador do
  def cotizar(%{peso_kg: peso}, _reglas) when peso <= 0 do
    {:error, :peso_invalido}
  end

  def cotizar(_embarque, _reglas) do
    {:error, :no_implementado}
  end

  def resumen(_lote, _reglas) do
    {:error, :no_implementado}
  end
end
