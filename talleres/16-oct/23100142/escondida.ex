
defmodule Escondida do

  # 1. Ordenar los embarques por peso
  def ordenar_por_peso(embarques) do
    Enum.sort_by(embarques, fn e -> e.peso_kg end)
  end

  # 2. Cambiar el descuento
  def con_descuento(reglas, pct) do
    %{reglas | descuento_pct: pct}
  end

  # 3. Agregar un ID a la lista
  def registrar(vistos, id) do
    vistos ++ [id]
  end

  # 4. Cambiar el permiso
  def con_permiso(embarque, permiso) do
    %{embarque | documentos: %{embarque.documentos | permiso: permiso}}
  end

  # 5. Sumar días a la fecha
  def fecha_de_entrega(salida, dias) do
    Date.add(salida, dias)
  end

end
