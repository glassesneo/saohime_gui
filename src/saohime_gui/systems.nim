import
  pkg/saohime,
  pkg/saohime/default_plugins,
  ./components

proc changeButtonColor*(
    buttonQuery: [All[Texture, Button, ButtonStyle, Transform]],
    mouseEvent: Event[MouseButtonEvent]
) {.system.} =
  for event in mouseEvent:
    if event.isPressed(ButtonLeft):
      for _, button, texture, style, tf in buttonQuery[
        Button, Texture, ButtonStyle, Transform
      ]:
        if tf.position <= event.position and event.position <= tf.position + button.size:
          texture.texture = style.down.texture

    elif event.isReleased(ButtonLeft):
      for _, texture, style, tf in buttonQuery[Texture, ButtonStyle, Transform]:
        texture.texture = style.normal.texture

