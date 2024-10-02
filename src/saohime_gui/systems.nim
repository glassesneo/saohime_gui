import
  pkg/saohime,
  pkg/saohime/default_plugins,
  ./components

proc changeNormalButtonColor*(
    buttonQuery: [All[Texture, NormalButton, ButtonStyle, Transform]],
    mouseEvent: Event[MouseButtonEvent]
) {.system.} =
  for e in mouseEvent:
    if e.isPressed(ButtonLeft):
      for _, renderable, texture, style, tf in buttonQuery[
        Renderable, Texture, ButtonStyle, Transform
      ]:
        if e.position in (tf.position, renderable.srcSize):
          texture.texture = style.down.texture

    elif e.isReleased(ButtonLeft):
      for _, texture, style, tf in buttonQuery[Texture, ButtonStyle, Transform]:
        texture.texture = style.normal.texture

