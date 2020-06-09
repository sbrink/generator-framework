defmodule PlatformWeb.GeneratorController do
  use PlatformWeb, :controller

  alias Platform.Core.Generators
  alias Platform.Core.Templates
  alias Platform.Core.Generators.Generator

  def index(conn, _params) do
    generators = Generators.list()
    render(conn, "index.html", generators: generators)
  end

  def new(conn, _params) do
    changeset = Generators.change(%Generator{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"generator" => generator_params}) do
    case Generators.create(generator_params) do
      {:ok, generator} ->
        conn
        |> put_flash(:info, "Generator created successfully.")
        |> redirect(to: Routes.generator_path(conn, :show, generator))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    generator = Generators.get!(id)
    templates = Templates.list_for_generator(id)
    render(conn, "show.html", generator: generator, templates: templates)
  end

  def edit(conn, %{"id" => id}) do
    generator = Generators.get!(id)
    changeset = Generators.change(generator)
    render(conn, "edit.html", generator: generator, changeset: changeset)
  end

  def update(conn, %{"id" => id, "generator" => generator_params}) do
    generator = Generators.get!(id)

    case Generators.update(generator, generator_params) do
      {:ok, generator} ->
        conn
        |> put_flash(:info, "Generator updated successfully.")
        |> redirect(to: Routes.generator_path(conn, :show, generator))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", generator: generator, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    generator = Generators.get!(id)
    {:ok, _generator} = Generators.delete(generator)

    conn
    |> put_flash(:info, "Generator deleted successfully.")
    |> redirect(to: Routes.generator_path(conn, :index))
  end
end
