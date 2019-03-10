defmodule PhxguideWeb.LayoutView do
  use PhxguideWeb, :view

  def map_to_html(map) do
    keys = Map.keys(map)
    map_to_html(map, keys)
  end

  defp map_to_html(map, [key | keys]) do
    "#{key}: #{Map.get(map, key)} ---- " <> map_to_html(map, keys)
  end

  defp map_to_html(map, []), do: ""
end
