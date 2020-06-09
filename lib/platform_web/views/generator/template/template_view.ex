defmodule PlatformWeb.Generator.TemplateView do
  use PlatformWeb, :view

  alias PlatformWeb.GeneratorView

  # Page Meta Configuration
  def page_meta("show.html", conn),
    do: %PageMeta{
      parent: GeneratorView.page_meta("show.html", conn),
      title: "#{conn.assigns.template.file}",
      path: Routes.generator_template_path(conn, :show, conn.assigns.generator, conn.assigns.template)
    }

  def page_meta("new.html", conn),
    do: %PageMeta{
      parent: GeneratorView.page_meta("show.html", conn),
      title: "New template"
    }

  def page_meta("edit.html", conn),
    do: %PageMeta{
      parent: page_meta("show.html", conn),
      title: "Edit template"
    }
end
