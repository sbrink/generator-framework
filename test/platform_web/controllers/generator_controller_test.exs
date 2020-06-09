defmodule PlatformWeb.GeneratorControllerTest do
  use PlatformWeb.ConnCase

  alias Phoenix.QuickGen.Generators

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:generator) do
    {:ok, generator} = Generators.create_generator(@create_attrs)
    generator
  end

  describe "index" do
    test "lists all generators", %{conn: conn} do
      conn = get(conn, Routes.generator_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Generators"
    end
  end

  describe "new generator" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.generator_path(conn, :new))
      assert html_response(conn, 200) =~ "New Generator"
    end
  end

  describe "create generator" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.generator_path(conn, :create), generator: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.generator_path(conn, :show, id)

      conn = get(conn, Routes.generator_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Generator"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.generator_path(conn, :create), generator: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Generator"
    end
  end

  describe "edit generator" do
    setup [:create_generator]

    test "renders form for editing chosen generator", %{conn: conn, generator: generator} do
      conn = get(conn, Routes.generator_path(conn, :edit, generator))
      assert html_response(conn, 200) =~ "Edit Generator"
    end
  end

  describe "update generator" do
    setup [:create_generator]

    test "redirects when data is valid", %{conn: conn, generator: generator} do
      conn = put(conn, Routes.generator_path(conn, :update, generator), generator: @update_attrs)
      assert redirected_to(conn) == Routes.generator_path(conn, :show, generator)

      conn = get(conn, Routes.generator_path(conn, :show, generator))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, generator: generator} do
      conn = put(conn, Routes.generator_path(conn, :update, generator), generator: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Generator"
    end
  end

  describe "delete generator" do
    setup [:create_generator]

    test "deletes chosen generator", %{conn: conn, generator: generator} do
      conn = delete(conn, Routes.generator_path(conn, :delete, generator))
      assert redirected_to(conn) == Routes.generator_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.generator_path(conn, :show, generator))
      end
    end
  end

  defp create_generator(_) do
    generator = fixture(:generator)
    %{generator: generator}
  end
end
