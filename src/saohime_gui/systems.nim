import
  pkg/saohime,
  pkg/saohime/default_plugins,
  ./components,
  ./events

proc dispatchGUIClickEvent*(
    clickables: [
      All[Widget, Transform],
      Any[NormalButton],
    ],
    mouseEvent: Event[MouseButtonEvent]
) {.system.} =
  for event in mouseEvent:
    for entity, renderable, tf in clickables[Renderable, Transform]:
      if not entity[Widget].sensitive:
        continue

      if event.pressedButtons.len != 0:
        if event.position in (tf.position, renderable.srcSize):
          let clickEvent = GUIClickEvent.new(
            entity.id,
            event.pressedButtons,
            event.position
          )
          commands.dispatchEvent(clickEvent)
      elif event.releasedButtons.len != 0:
        let releaseEvent = GUIReleaseEvent.new(
          entity.id,
          event.releasedButtons,
          event.position
        )
        commands.dispatchEvent(releaseEvent)

proc changeNormalButtonColor*(
    buttonQuery: [All[NormalButton, ButtonStyle]],
    clickEvent: Event[GUIClickEvent],
    releaseEvent: Event[GUIReleaseEvent],
) {.system.} =
  for entity, texture, style in buttonQuery[Texture, ButtonStyle]:
    for event in clickEvent:
      if entity.id != event.id:
        continue
      if event.isClicked(ButtonLeft):
        texture.texture = style.down.texture

    for event in releaseEvent:
      if entity.id != event.id:
        continue
      if event.isReleased(ButtonLeft):
        texture.texture = style.normal.texture

