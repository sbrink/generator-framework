defmodule PlatformWeb.Router do
  use PlatformWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", PlatformWeb do
    pipe_through :browser

    get "/", PageController, :index

    resources "/generators", GeneratorController do
      resources "/templates", Generator.TemplateController, except: [:index]
    end
  end
end
