defmodule <%= inspect context.web_module %>.<%= inspect Module.concat(schema.web_namespace, schema.alias) %>Controller do
  use <%= inspect context.web_module %>, :controller

  alias <%= context.module %>

  def index(conn, _params) do
    {_, conn} = <%= inspect context.alias %> |> authorize_action!(conn)
    <%= schema.plural %> = <%= inspect context.alias %>.list()
    render(conn, "index.html", <%= schema.plural %>: <%= schema.plural %>)
  end

  def show(conn, %{"id" => id}) do
    {<%= schema.singular %>, conn} = <%= inspect context.alias %>.get!(id) |> authorize_action!(conn)
    render(conn, "show.html", <%= schema.singular %>: <%= schema.singular %>)
  end

  def new(conn, _params) do
    {_, conn} = <%= inspect context.alias %> |> authorize_action!(conn)
    changeset = <%= inspect context.alias %>.change(%{}, :create)
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{<%= inspect schema.singular %> => <%= schema.singular %>_params}) do
    {_, conn} = <%= inspect context.alias %> |> authorize_action!(conn)

    case <%= inspect context.alias %>.create(<%= schema.singular %>_params) do
      {:ok, <%= schema.singular %>} ->
        conn
        |> put_flash(:info, "<%= schema.human_singular %> created successfully.")
        |> redirect(to: Routes.<%= schema.route_helper %>_path(conn, :show, <%= schema.singular %>))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    {<%= schema.singular %>, conn} = <%= inspect context.alias %>.get!(id) |> authorize_action!(conn)
    changeset = <%= inspect context.alias %>.change(<%= schema.singular %>, :update)
    render(conn, "edit.html", <%= schema.singular %>: <%= schema.singular %>, changeset: changeset)
  end

  def update(conn, %{"id" => id, <%= inspect schema.singular %> => <%= schema.singular %>_params}) do
    {<%= schema.singular %>, conn} = <%= inspect context.alias %>.get!(id) |> authorize_action!(conn)

    case <%= inspect context.alias %>.update(<%= schema.singular %>, <%= schema.singular %>_params, :update) do
      {:ok, <%= schema.singular %>} ->
        conn
        |> put_flash(:info, "<%= schema.human_singular %> updated successfully.")
        |> redirect(to: Routes.<%= schema.route_helper %>_path(conn, :show, <%= schema.singular %>))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", <%= schema.singular %>: <%= schema.singular %>, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    {<%= schema.singular %>, conn} = <%= inspect context.alias %>.get!(id) |> authorize_action!(conn)
    {:ok, _<%= schema.singular %>} = <%= inspect context.alias %>.delete(<%= schema.singular %>)

    conn
    |> put_flash(:info, "<%= schema.human_singular %> deleted successfully.")
    |> redirect(to: Routes.<%= schema.route_helper %>_path(conn, :index))
  end
end
