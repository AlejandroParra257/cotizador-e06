defmodule Cotizador do
  def cotizar(%{peso_kg: peso}, _reglas) when peso <= 0 do
    {:error, :peso_invalido}
  end

  def cotizar(%{distancia_km: dist}, _reglas) when dist <= 0 do
    {:error, :distancia_invalida}
  end

  def cotizar(%{tipo: :peligrosa, numero_un: nil}, _reglas) do
    {:error, :falta_numero_un}
  end

  def cotizar(%{tipo: :sobredimensionada, permiso: nil}, _reglas) do
    {:error, :falta_permiso}
  end

  def cotizar(%{tipo: tipo}, _reglas)
      when tipo not in [:general, :refrigerada, :peligrosa, :sobredimensionada] do
    {:error, :tipo_desconocido}
  end

  def cotizar(%{puente: puente}, reglas)
      when not is_map_key(reglas.cuota_puente, puente) do
    {:error, :puente_desconocido}
  end

  def cotizar(%{tipo: tipo, peso_kg: peso, permiso: permiso}, reglas)
      when tipo != :sobredimensionada and peso > reglas.peso_maximo_kg do
    {:error, :excede_peso_maximo}
  end

  def cotizar(_embarque, _reglas) do
    {:error, :no_implementado}
  end

  def resumen(_lote, _reglas) do
    {:error, :no_implementado}
  end
end
