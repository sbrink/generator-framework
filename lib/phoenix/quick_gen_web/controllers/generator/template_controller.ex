defmodule Phoenix.QuickGenWeb.Generator.TemplateController do
  use Phoenix.QuickGenWeb, :controller

  alias Phoenix.QuickGen.Generators
  alias Phoenix.QuickGen.Templates

  def show(conn, %{"generator_id" => generator_id, "id" => id}) do
    generator = Generators.get!(generator_id)
    template = Templates.get!(generator_id, id)
    render(conn, "show.html", generator: generator, template: template)
  end

  def edit(conn, %{"generator_id" => generator_id, "id" => id}) do
    generator = Generators.get!(generator_id)
    template = Templates.get!(generator_id, id)
    changeset = Templates.change(template, :update)
    render(conn, "edit.html", generator: generator, template: template, changeset: changeset)
  end

  def update(conn, %{"generator_id" => generator_id, "id" => id, "template" => template_params}) do
    generator = Generators.get!(generator_id)
    template = Templates.get!(generator_id, id)

    case Templates.update(template, template_params, :update) do
      {:ok, template} ->
        conn
        |> put_flash(:info, "Template updated successfully.")
        |> redirect(to: Routes.generator_template_path(conn, :show, generator, template))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", generator: generator, template: template, changeset: changeset)
    end
  end
end
