import
  saohime,
  saohime/default_plugins,
  ../src/saohime_gui

proc setup(renderer: Resource[Renderer]) {.system.} =
  let buttonSize = Vector.new(50f, 50f)
  commands.create()
    .ButtonBundle(
      size = buttonSize,
      style = renderer.createButtonColors(size = buttonSize),
    )
    .attach(Transform.new(x = 5, y = 5))

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

