%Platform.Core.Generators.Generator{
  id: "phx.gen.html.custom",
  name: "Phx custom generator",
  templates: [
    %Platform.Core.Templates.Template{
      id: "controller.ex",
      file: "controller.ex",
      syntax: "elixir"
    },
    %Platform.Core.Templates.Template{
      id: "new.html.eex",
      file: "new.html.eex",
      syntax: "html"
    },
    %Platform.Core.Templates.Template{
      id: "edit.html.eex",
      file: "edit.html.eex",
      syntax: "html"
    }
  ],
  func: fn config -> config <> "124" end
}
