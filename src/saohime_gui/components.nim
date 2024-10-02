import
  std/colors,
  std/importutils,
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

  NormalButton* = ref object

  ButtonStyle* = ref object
    normal*, hover*, down*: Texture

proc new*(T: type Widget; sensitive = true): T {.construct.}

proc new*(T: type NormalButton): T {.construct.}

proc new*(T: type ButtonStyle; normal, hover, down: Texture): T {.construct.}

proc createButtonStyle*(
    renderer: Renderer;
    size: Vector;
    normalColor, hoverColor, downColor: SaohimeColor
): ButtonStyle =
  result = ButtonStyle.new(
    renderer.createRectangleTexture(normalColor, size),
    renderer.createRectangleTexture(hoverColor, size),
    renderer.createRectangleTexture(downColor, size)
  )

proc NormalButtonBundle*(
    entity: Entity;
    size: Vector;
    sensitive = true;
    normalColor = DefaultNormalColor;
    hoverColor = DefaultHoverColor;
    downColor = DefaultDownColor;
    renderingOrder = 0
): Entity {.discardable.} =
  privateAccess(Entity)
  let renderer = entity.world.getResource(Renderer)
  let buttonStyle = renderer.createButtonStyle(
    size,
    normalColor,
    hoverColor,
    downColor,
  )

  return entity.withBundle((
    Texture.new(buttonStyle.normal.texture),
    Renderable.new(
      srcPosition = ZeroVector,
      srcSize = size,
      renderingOrder = renderingOrder
    ),
    Widget.new(sensitive),
    NormalButton.new(),
    buttonStyle
  ))

