%Platform.Core.Generators.Generator{
  id: "phx.gen.html.custom",
  name: "Phx custom generator",
  templates: [
    %Platform.Core.Templates.Template{
      id: "controller.ex",
      file: "controller.ex"
    }
  ],
  func: fn config -> config <> "124" end
}
