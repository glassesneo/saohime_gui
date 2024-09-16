import
  pkg/saohime,
  saohime_gui/[components, systems]

type
  GUIPlugin* = ref object

proc build*(plugin: GUIPlugin, world: World) =
  world.registerSystemsAt("update", changeButtonColor)

export
  components,
  systems

