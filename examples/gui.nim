import
  saohime,
  saohime/default_plugins,
  ../src/saohime_gui

proc setup(renderer: Resource[Renderer]) {.system.} =
  let buttonSize = Vector.new(50f, 50f)
  commands.create()
    .NormalButtonBundle(
      size = buttonSize,
    )
    .attach(Transform.new(x = 5, y = 5))

  commands.create()
    .NormalButtonBundle(
      size = buttonSize,
      # sensitive = false,
    )
    .attach(Transform.new(x = 250, y = 100))

proc pollEvent(appEvent: Event[ApplicationEvent]) {.system.} =
  for e in appEvent:
    let app = commands.getResource(Application)
    app.terminate()

let app = Application.new()

app.loadPluginGroup(DefaultPlugins)
app.loadPlugin(GUIPlugin)

app.start:
  world.registerStartupSystems(setup)
  world.registerSystems(pollEvent)

