import
  std/colors,
  pkg/seiryu,
  pkg/saohime,
  pkg/saohime/default_plugins

const
  DefaultNormalColor* = colGhostWhite.toSaohimeColor()
  DefaultHoverColor* = colRoyalBlue.toSaohimeColor()
  DefaultDownColor* = colBlue.toSaohimeColor()

type
  Widget* = ref object
    sensitive*: bool

  Button* = ref object
    size*: Vector

  ButtonStyle* = ref object
    normal*, hover*, down*: Texture

proc new*(T: type Widget; sensitive = true): T {.construct.}

proc new*(T: type Button; size: Vector): T {.construct.}

proc new*(T: type ButtonStyle; normal, hover, down: Texture): T {.construct.}

proc createButtonColors*(
    renderer: Renderer;
    normal = DefaultNormalColor;
    hover = DefaultHoverColor;
    down = DefaultDownColor;
    size: Vector
): ButtonStyle =
  result = ButtonStyle.new(
    renderer.createRectangleTexture(normal, size),
    renderer.createRectangleTexture(hover, size),
    renderer.createRectangleTexture(down, size)
  )

proc ButtonBundle*(
    entity: Entity;
    size: Vector;
    sensitive = true;
    style: ButtonStyle;
    renderingOrder = 0
): Entity {.discardable.} =
  return entity.withBundle((
    Texture.new(style.normal.texture),
    Renderable.new(
      srcPosition = ZeroVector,
      srcSize = size,
      renderingOrder = renderingOrder
    ),
    Widget.new(sensitive),
    Button.new(size),
    style
  ))

