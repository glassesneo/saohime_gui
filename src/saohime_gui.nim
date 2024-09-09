import
  pkg/saohime

type
  GUIPlugin* = ref object

proc build*(plugin: GUIPlugin, world: World) =
  discard

