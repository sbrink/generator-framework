defmodule Phoenix.QuickGen.GeneratorsTest do
  use Platform.DataCase

  alias Phoenix.QuickGen.Generators

  describe "generators" do
    alias Phoenix.QuickGen.Generators.Generator

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def generator_fixture(attrs \\ %{}) do
      {:ok, generator} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Generators.create_generator()

      generator
    end

    test "list_generators/0 returns all generators" do
      generator = generator_fixture()
      assert Generators.list_generators() == [generator]
    end

    test "get_generator!/1 returns the generator with given id" do
      generator = generator_fixture()
      assert Generators.get_generator!(generator.id) == generator
    end

    test "create_generator/1 with valid data creates a generator" do
      assert {:ok, %Generator{} = generator} = Generators.create_generator(@valid_attrs)
      assert generator.name == "some name"
    end

    test "create_generator/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Generators.create_generator(@invalid_attrs)
    end

    test "update_generator/2 with valid data updates the generator" do
      generator = generator_fixture()
      assert {:ok, %Generator{} = generator} = Generators.update_generator(generator, @update_attrs)
      assert generator.name == "some updated name"
    end

    test "update_generator/2 with invalid data returns error changeset" do
      generator = generator_fixture()
      assert {:error, %Ecto.Changeset{}} = Generators.update_generator(generator, @invalid_attrs)
      assert generator == Generators.get_generator!(generator.id)
    end

    test "delete_generator/1 deletes the generator" do
      generator = generator_fixture()
      assert {:ok, %Generator{}} = Generators.delete_generator(generator)
      assert_raise Ecto.NoResultsError, fn -> Generators.get_generator!(generator.id) end
    end

    test "change_generator/1 returns a generator changeset" do
      generator = generator_fixture()
      assert %Ecto.Changeset{} = Generators.change_generator(generator)
    end
  end
end
