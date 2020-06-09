defmodule PlatformWeb.Generator.TemplateController do
  use PlatformWeb, :controller

  alias Platform.Core.Generators
  alias Platform.Core.Templates
  alias Platform.Core.Templates.Template

  def show(conn, %{"generator_id" => generator_id, "id" => id}) do
    generator = Generators.get!(generator_id)
    template = Templates.get!(generator_id, id)
    render(conn, "show.html", generator: generator, template: template)
  end

  def new(conn, _params) do
    changeset = Templates.change_template(%Template{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"template" => template_params}) do
    case Templates.create_template(template_params) do
      {:ok, template} ->
        conn
        |> put_flash(:info, "Template created successfully.")
        |> redirect(to: Routes.template_path(conn, :show, template))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    template = Templates.get!(id)
    changeset = Templates.change_template(template)
    render(conn, "edit.html", template: template, changeset: changeset)
  end

  def update(conn, %{"id" => id, "template" => template_params}) do
    template = Templates.get!(id)

    case Templates.update_template(template, template_params) do
      {:ok, template} ->
        conn
        |> put_flash(:info, "Template updated successfully.")
        |> redirect(to: Routes.template_path(conn, :show, template))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", template: template, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    template = Templates.get!(id)
    {:ok, _template} = Templates.delete_template(template)

    conn
    |> put_flash(:info, "Template deleted successfully.")
    |> redirect(to: Routes.template_path(conn, :index))
  end
end
