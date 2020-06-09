defmodule Phoenix.QuickGenWeb.AssetController do
  use Phoenix.QuickGenWeb, :controller

  def show(conn, %{"id" => "app.js"}) do
    js_path = Path.join(__DIR__, "../../../../priv/static/js/app.js")

    conn
    |> put_resp_content_type("text/javascript")
    |> Plug.Conn.put_private(:plug_skip_csrf_protection, true)
    |> send_resp(200, File.read!(js_path))
  end

  def show(conn, %{"id" => "app.css"}) do
    css_path = Path.join(__DIR__, "../../../../priv/static/css/app.css")

    conn
    |> put_resp_content_type("text/css")
    |> send_resp(200, File.read!(css_path))
  end
end
