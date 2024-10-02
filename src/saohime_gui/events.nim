import
  pkg/saohime,
  pkg/seiryu

type
  GUIClickEvent* = object
    id*: EntityId
    buttons*: set[uint8]
    position: Vector

  GUIReleaseEvent* = object
    id*: EntityId
    buttons*: set[uint8]
    position: Vector

proc new*(
    T: type GUIClickEvent,
    id: EntityId,
    buttons: set[uint8],
    position: Vector
): T {.construct.}

proc position*(event: GUIClickEvent): Vector =
  return event.position

proc isClicked*(event: GUIClickEvent, button: uint8): bool =
  return button in event.buttons

proc new*(
    T: type GUIReleaseEvent,
    id: EntityId,
    buttons: set[uint8],
    position: Vector
): T {.construct.}

proc position*(event: GUIReleaseEvent): Vector =
  return event.position

proc isReleased*(event: GUIReleaseEvent, button: uint8): bool =
  return button in event.buttons

