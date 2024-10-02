import
  pkg/saohime,
  saohime_gui/[components, events, systems]

type
  GUIPlugin* = ref object

proc build*(plugin: GUIPlugin, world: World) =
  world.addEvent(GUIClickEvent)
  world.addEvent(GUIReleaseEvent)
  world.registerSystemsAt("first", dispatchGUIClickEvent)
  world.registerSystemsAt("update", changeNormalButtonColor)

export
  components,
  systems

