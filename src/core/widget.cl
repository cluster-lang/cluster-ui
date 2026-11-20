// ==============================================================================
// Cluster UI: Core Declarative Widget Model
// Equivalent to Flutter: Widget, StatelessWidget, RenderObjectWidget
// Equivalent to SwiftUI: View, PrimitiveView
// ==============================================================================

model Widget:
    kind: int             // 1:Text, 2:Button, 3:Column, 4:Row, 5:Box, 6:Spacer, 7:TextInput, 8:Image
    id: string
    text: string
    font_size: int
    bold: bool
    color: string
    bg_color: string
    width: int
    height: int
    padding: int
    margin: int
    border_radius: int
    border_color: string
    border_width: int
    spacing: int
    on_click: string
    placeholder: string
    image_url: string
    children: vector[Widget]

// Helper Factory Constructors

fn Text(content: string, font_size: int = 14, color: string = "#e6edf3", bold: bool = false) -> Widget:
    let empty_children: vector[Widget] = []
    return Widget(
        kind = 1,
        id = "",
        text = content,
        font_size = font_size,
        bold = bold,
        color = color,
        bg_color = "",
        width = 0,
        height = 0,
        padding = 0,
        margin = 0,
        border_radius = 0,
        border_color = "",
        border_width = 0,
        spacing = 0,
        on_click = "",
        placeholder = "",
        image_url = "",
        children = empty_children
    )

fn Button(label: string, on_click: string = "", bg_color: string = "#238636", text_color: string = "#ffffff", font_size: int = 14) -> Widget:
    let empty_children: vector[Widget] = []
    return Widget(
        kind = 2,
        id = "",
        text = label,
        font_size = font_size,
        bold = true,
        color = text_color,
        bg_color = bg_color,
        width = 0,
        height = 0,
        padding = 10,
        margin = 0,
        border_radius = 6,
        border_color = "",
        border_width = 0,
        spacing = 0,
        on_click = on_click,
        placeholder = "",
        image_url = "",
        children = empty_children
    )

fn Column(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    return Widget(
        kind = 3,
        id = "",
        text = "",
        font_size = 0,
        bold = false,
        color = "",
        bg_color = "",
        width = 0,
        height = 0,
        padding = padding,
        margin = 0,
        border_radius = 0,
        border_color = "",
        border_width = 0,
        spacing = spacing,
        on_click = "",
        placeholder = "",
        image_url = "",
        children = children
    )

fn Row(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    return Widget(
        kind = 4,
        id = "",
        text = "",
        font_size = 0,
        bold = false,
        color = "",
        bg_color = "",
        width = 0,
        height = 0,
        padding = padding,
        margin = 0,
        border_radius = 0,
        border_color = "",
        border_width = 0,
        spacing = spacing,
        on_click = "",
        placeholder = "",
        image_url = "",
        children = children
    )

fn Box(child: Widget, width: int = 0, height: int = 0, padding: int = 0, bg_color: string = "", border_radius: int = 0) -> Widget:
    let mut ch: vector[Widget] = []
    ch.push(child)
    return Widget(
        kind = 5,
        id = "",
        text = "",
        font_size = 0,
        bold = false,
        color = "",
        bg_color = bg_color,
        width = width,
        height = height,
        padding = padding,
        margin = 0,
        border_radius = border_radius,
        border_color = "",
        border_width = 0,
        spacing = 0,
        on_click = "",
        placeholder = "",
        image_url = "",
        children = ch
    )

fn Spacer() -> Widget:
    let empty_children: vector[Widget] = []
    return Widget(
        kind = 6,
        id = "",
        text = "",
        font_size = 0,
        bold = false,
        color = "",
        bg_color = "",
        width = 0,
        height = 0,
        padding = 0,
        margin = 0,
        border_radius = 0,
        border_color = "",
        border_width = 0,
        spacing = 0,
        on_click = "",
        placeholder = "",
        image_url = "",
        children = empty_children
    )

fn TextInput(placeholder: string = "Type here...", font_size: int = 14) -> Widget:
    let empty_children: vector[Widget] = []
    return Widget(
        kind = 7,
        id = "",
        text = "",
        font_size = font_size,
        bold = false,
        color = "#e6edf3",
        bg_color = "#161b22",
        width = 0,
        height = 0,
        padding = 8,
        margin = 0,
        border_radius = 6,
        border_color = "#30363d",
        border_width = 1,
        spacing = 0,
        on_click = "",
        placeholder = placeholder,
        image_url = "",
        children = empty_children
    )
