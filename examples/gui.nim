import
  saohime,
  saohime/default_plugins,
  ../src/saohime_gui

proc pollEvent(appEvent: Event[ApplicationEvent]) {.system.} =
  for e in appEvent:
    let app = commands.getResource(Application)
    app.terminate()

let app = Application.new()

app.loadPluginGroup(DefaultPlugins)
app.loadPlugin(GUIPlugin)

app.start:
  world.registerSystems(pollEvent)

