// ==============================================================================
// Cluster UI: Declarative Multi-Platform Widget Model
// Inspired by Flutter (Widget, RenderObject) and SwiftUI (View, ViewModifier)
// Pure Cluster Language — 100% Zero Dependencies, Zero External Runtimes
// ==============================================================================

model Widget:
    kind: int             // 1:Text, 2:Button, 3:Column/VStack, 4:Row/HStack, 5:Box/Container,
                          // 6:Spacer, 7:TextInput, 8:Image, 9:ZStack/Stack, 10:Divider,
                          // 11:Card, 12:Badge/Chip, 13:Toggle/Switch, 14:ProgressBar,
                          // 15:ListTile, 16:Center, 17:Link, 18:Expanded, 19:AppBar
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
    url: string
    subtitle: string
    icon_name: string
    value: int
    is_checked: bool
    shadow: bool
    align: string
    flex: int
    children: vector[Widget]

// Base factory to initialize defaults
fn new_widget(kind: int) -> Widget:
    let empty_ch: vector[Widget] = []
    return Widget(
        kind = kind,
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
        url = "",
        subtitle = "",
        icon_name = "",
        value = 0,
        is_checked = false,
        shadow = false,
        align = "",
        flex = 0,
        children = empty_ch
    )

// --- Primitive & Content Widgets ---

// Text (Flutter Text / SwiftUI Text)
fn Text(content: string, font_size: int = 14, color: string = "#e6edf3", bold: bool = false) -> Widget:
    let mut w: Widget = new_widget(1)
    w.text = content
    w.font_size = font_size
    w.color = color
    w.bold = bold
    return w

// Button (Flutter ElevatedButton / SwiftUI Button)
fn Button(label: string, on_click: string = "", bg_color: string = "#238636", text_color: string = "#ffffff", font_size: int = 14) -> Widget:
    let mut w: Widget = new_widget(2)
    w.text = label
    w.on_click = on_click
    w.bg_color = bg_color
    w.color = text_color
    w.font_size = font_size
    w.bold = true
    w.padding = 10
    w.border_radius = 6
    return w

// TextInput (Flutter TextField / SwiftUI TextField)
fn TextInput(placeholder: string = "Type here...", font_size: int = 14) -> Widget:
    let mut w: Widget = new_widget(7)
    w.placeholder = placeholder
    w.font_size = font_size
    w.color = "#e6edf3"
    w.bg_color = "#161b22"
    w.padding = 10
    w.border_radius = 6
    w.border_color = "#30363d"
    w.border_width = 1
    return w

// Image (Flutter Image.network / SwiftUI Image)
fn Image(url: string, width: int = 0, height: int = 0, border_radius: int = 0, alt: string = "") -> Widget:
    let mut w: Widget = new_widget(8)
    w.image_url = url
    w.width = width
    w.height = height
    w.border_radius = border_radius
    w.text = alt
    return w

// Badge / Chip (Flutter Chip / SwiftUI Badge)
fn Badge(text: string, bg_color: string = "#1f6feb", color: string = "#ffffff", font_size: int = 11) -> Widget:
    let mut w: Widget = new_widget(12)
    w.text = text
    w.bg_color = bg_color
    w.color = color
    w.font_size = font_size
    w.bold = true
    w.padding = 4
    w.border_radius = 12
    return w

// Link (Flutter InkWell / SwiftUI Link)
fn Link(text: string, url: string, color: string = "#58a6ff", font_size: int = 14) -> Widget:
    let mut w: Widget = new_widget(17)
    w.text = text
    w.url = url
    w.color = color
    w.font_size = font_size
    return w

// Toggle / Switch (Flutter Switch / SwiftUI Toggle)
fn Toggle(is_checked: bool = false, label: string = "", on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(13)
    w.is_checked = is_checked
    w.text = label
    w.on_click = on_click
    return w

// ProgressBar (Flutter LinearProgressIndicator / SwiftUI ProgressView)
fn ProgressBar(value: int = 0, color: string = "#238636", bg_color: string = "#21262d", height: int = 8) -> Widget:
    let mut w: Widget = new_widget(14)
    w.value = value
    w.color = color
    w.bg_color = bg_color
    w.height = height
    w.border_radius = height / 2
    return w

// Divider (Flutter Divider / SwiftUI Divider)
fn Divider(color: string = "#30363d", height: int = 1) -> Widget:
    let mut w: Widget = new_widget(10)
    w.bg_color = color
    w.height = height
    return w

// --- Layout & Container Widgets ---

// Column / VStack (Flutter Column / SwiftUI VStack)
fn Column(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    let mut w: Widget = new_widget(3)
    w.children = children
    w.spacing = spacing
    w.padding = padding
    return w

// SwiftUI alias for Column
fn VStack(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    return Column(children, spacing, padding)

// Row / HStack (Flutter Row / SwiftUI HStack)
fn Row(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    let mut w: Widget = new_widget(4)
    w.children = children
    w.spacing = spacing
    w.padding = padding
    return w

// SwiftUI alias for Row
fn HStack(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    return Row(children, spacing, padding)

// ZStack / Stack (Flutter Stack / SwiftUI ZStack)
fn ZStack(children: vector[Widget], align: string = "center") -> Widget:
    let mut w: Widget = new_widget(9)
    w.children = children
    w.align = align
    return w

// Flutter alias for ZStack
fn Stack(children: vector[Widget], align: string = "center") -> Widget:
    return ZStack(children, align)

// Box / Container (Flutter Container / SwiftUI Frame)
fn Box(child: Widget, width: int = 0, height: int = 0, padding: int = 0, bg_color: string = "", border_radius: int = 0) -> Widget:
    let mut w: Widget = new_widget(5)
    let mut ch: vector[Widget] = []
    ch.push(child)
    w.children = ch
    w.width = width
    w.height = height
    w.padding = padding
    w.bg_color = bg_color
    w.border_radius = border_radius
    return w

// Center (Flutter Center / SwiftUI center frame)
fn Center(child: Widget) -> Widget:
    let mut w: Widget = new_widget(16)
    let mut ch: vector[Widget] = []
    ch.push(child)
    w.children = ch
    return w

// Expanded (Flutter Expanded / SwiftUI flexible)
fn Expanded(child: Widget, flex: int = 1) -> Widget:
    let mut w: Widget = new_widget(18)
    let mut ch: vector[Widget] = []
    ch.push(child)
    w.children = ch
    w.flex = flex
    return w

// Spacer (Flutter Spacer / SwiftUI Spacer)
fn Spacer() -> Widget:
    return new_widget(6)

// Card (Flutter Card / SwiftUI GroupBox)
fn Card(child: Widget, bg_color: string = "#161b22", border_radius: int = 12, padding: int = 16) -> Widget:
    let mut w: Widget = new_widget(11)
    let mut ch: vector[Widget] = []
    ch.push(child)
    w.children = ch
    w.bg_color = bg_color
    w.border_radius = border_radius
    w.padding = padding
    w.shadow = true
    return w

// ListTile (Flutter ListTile / SwiftUI NavigationLink label)
fn ListTile(title: string, subtitle: string = "", icon_name: string = "", on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(15)
    w.text = title
    w.subtitle = subtitle
    w.icon_name = icon_name
    w.on_click = on_click
    return w

// AppBar / NavigationBar (Flutter AppBar / SwiftUI NavigationTitle)
fn AppBar(title: string, leading: Widget, trailing: Widget, bg_color: string = "#161b22") -> Widget:
    let mut w: Widget = new_widget(19)
    w.text = title
    w.bg_color = bg_color
    let mut ch: vector[Widget] = []
    ch.push(leading)
    ch.push(trailing)
    w.children = ch
    return w
