defmodule Phoenix.QuickGenWeb.LayoutView do
  use Phoenix.QuickGenWeb, :view

  def page_meta(conn) do
    apply(view_module(conn), :page_meta, [conn.private.phoenix_template, conn])
  end

  def breadcrumb_encode(%{parent: %{path: _} = parent} = map) when is_map(parent) do
    breadcrumb_encode(parent) ++ [breadcrumb_encode_single(map)]
  end

  def breadcrumb_encode(%{parent: parent}) when is_map(parent) do
    raise "Provide a link for parent"
  end

  def breadcrumb_encode(%{} = map) do
    [breadcrumb_encode_single(map)]
  end

  def breadcrumb_encode_single(%{title: title} = map) do
    {title, Map.get(map, :path)}
  end
end
