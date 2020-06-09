defmodule Phoenix.QuickGen.Router do
  @moduledoc """
  Provides routing for QuickGen.
  """

  @doc """
  Defines the QuickGen routes.

  It expects the `path` the generators will be mounted at.

  ## Example:

      defmodule MyAppWeb.Router do
        use Phoenix.Router
        import Phoenix.QuickGen.Router

        scope "/", MyAppWeb do
          pipe_through [:browser]
          quick_gen "/quick_gen"
        end
      end

  """
  defmacro quick_gen(path) do
    quote bind_quoted: binding() do
      scope path, alias: false, as: false do
        # use Phoenix.Router

        resources "/generators", PlatformWeb.GeneratorController do
          resources "/templates", PlatformWeb.Generator.TemplateController, only: [:show, :edit, :update]
        end
      end
    end
  end
end
