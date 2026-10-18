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

  def cotizar(%{tipo: tipo, peso_kg: peso, permiso: _permiso}, reglas)
      when tipo != :sobredimensionada and peso > reglas.peso_maximo_kg do
    {:error, :excede_peso_maximo}
  end

  def cotizar(embarque, reglas) do
    %{peso_kg: peso, distancia_km: distancia, tipo: tipo, puente: puente} = embarque

    flete_bruto = reglas.tarifa_km * distancia

    descuento =
      case reglas.descuento do
        %{criterio: :mas_de, pct: pct, umbral_kg: umbral} when peso > umbral ->
          round(flete_bruto * pct / 100)

        _ ->
          0
      end

    flete = flete_bruto - descuento

    recargo_tipo = reglas.recargo[tipo]
    recargo = recargo_tipo.fija + round(flete * recargo_tipo.pct / 100)

    cuota_puente = reglas.cuota_puente[puente]

    total_sin_minimo = flete + recargo + cuota_puente
    ajuste_minimo = max(reglas.minimo - total_sin_minimo, 0)
    total = total_sin_minimo + ajuste_minimo

    {:ok,
     %{
       id: embarque.id,
       flete_bruto: flete_bruto,
       descuento: descuento,
       flete: flete,
       recargo: recargo,
       cuota_puente: cuota_puente,
       ajuste_minimo: ajuste_minimo,
       total: total
     }}
  end

  def resumen(lote, reglas) do
    resultados = Enum.map(lote, fn embarque -> {embarque.id, cotizar(embarque, reglas)} end)

    cotizados =
      resultados
      |> Enum.filter(fn {_id, r} -> match?({:ok, _}, r) end)
      |> Enum.map(fn {_id, {:ok, c}} -> c end)

    rechazados =
      resultados
      |> Enum.filter(fn {_id, r} -> match?({:error, _}, r) end)
      |> Enum.map(fn {id, {:error, razon}} -> {id, razon} end)

    total = Enum.sum(Enum.map(cotizados, fn c -> c.total end))

    por_puente =
      cotizados
      |> Enum.group_by(fn c ->
        lote
        |> Enum.find(fn e -> e.id == c.id end)
        |> Map.get(:puente)
      end)
      |> Enum.map(fn {puente, cs} -> {puente, Enum.sum(Enum.map(cs, fn c -> c.total end))} end)
      |> Map.new()

    %{
      cotizados: length(cotizados),
      rechazados: rechazados,
      total: total,
      por_puente: por_puente
    }
  end
end
