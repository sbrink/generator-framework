defmodule PlatformWeb.PageController do
  use PlatformWeb, :controller

  def index(conn, _params) do
    conn
    |> redirect(to: "/quick_gen/generators")
  end
end
