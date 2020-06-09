defmodule Phoenix.QuickGenWeb.Router do
  @moduledoc """
  Provides routing for QuickGen.
  """
  use Phoenix.Router

  import Plug.Conn
  import Phoenix.Controller

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Phoenix.QuickGenWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/assets", AssetController, only: [:show]

    resources "/generators", GeneratorController do
      resources "/templates", Generator.TemplateController, only: [:show, :edit, :update]
    end
  end
end
