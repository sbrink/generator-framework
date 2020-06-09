defmodule Phoenix.QuickGenWeb.GeneratorView do
  use Phoenix.QuickGenWeb, :view

  # Page Meta Configuration
  def page_meta("index.html", conn),
    do: %PageMeta{
      title: "Generators",
      path: Routes.generator_path(conn, :index)
    }

  def page_meta("show.html", conn),
    do: %PageMeta{
      parent: page_meta("index.html", conn),
      title: "#{conn.assigns.generator.name}",
      path: Routes.generator_path(conn, :show, conn.assigns.generator)
    }

  def page_meta("new.html", conn),
    do: %PageMeta{
      parent: page_meta("index.html", conn),
      title: "New generator"
    }

  def page_meta("edit.html", conn),
    do: %PageMeta{
      parent: page_meta("show.html", conn),
      title: "Edit generator"
    }
end
