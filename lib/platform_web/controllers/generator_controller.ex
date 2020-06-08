defmodule PlatformWeb.GeneratorController do
  use PlatformWeb, :controller

  alias Platform.Core.Generators
  alias Platform.Core.Generators.Generator

  def index(conn, _params) do
    generators = Generators.list_generators()
    render(conn, "index.html", generators: generators)
  end

  def new(conn, _params) do
    changeset = Generators.change_generator(%Generator{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"generator" => generator_params}) do
    case Generators.create_generator(generator_params) do
      {:ok, generator} ->
        conn
        |> put_flash(:info, "Generator created successfully.")
        |> redirect(to: Routes.generator_path(conn, :show, generator))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    generator = Generators.get_generator!(id)
    render(conn, "show.html", generator: generator)
  end

  def edit(conn, %{"id" => id}) do
    generator = Generators.get_generator!(id)
    changeset = Generators.change_generator(generator)
    render(conn, "edit.html", generator: generator, changeset: changeset)
  end

  def update(conn, %{"id" => id, "generator" => generator_params}) do
    generator = Generators.get_generator!(id)

    case Generators.update_generator(generator, generator_params) do
      {:ok, generator} ->
        conn
        |> put_flash(:info, "Generator updated successfully.")
        |> redirect(to: Routes.generator_path(conn, :show, generator))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", generator: generator, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    generator = Generators.get_generator!(id)
    {:ok, _generator} = Generators.delete_generator(generator)

    conn
    |> put_flash(:info, "Generator deleted successfully.")
    |> redirect(to: Routes.generator_path(conn, :index))
  end
end
