// ==============================================================================
// Cluster UI: Declarative Multi-Platform Widget Model
// Inspired by Flutter (Widget, RenderObject) and SwiftUI (View, ViewModifier)
// Pure Cluster Language — 100% Zero Dependencies, Zero External Runtimes
// ==============================================================================

model Widget:
    kind: int             // 1:Text, 2:Button, 3:Column/VStack, 4:Row/HStack, 5:Box/Container,
                          // 6:Spacer, 7:TextInput, 8:Image, 9:ZStack/Stack, 10:Divider,
                          // 11:Card, 12:Badge/Chip, 13:Toggle/Switch, 14:ProgressBar,
                          // 15:ListTile, 16:Center, 17:Link, 18:Expanded, 19:AppBar,
                          // 20:BottomNavigationBar, 21:TabItem, 22:FloatingActionButton,
                          // 23:Dialog, 24:SnackBar, 25:Grid, 26:Wrap, 27:Avatar, 28:Dropdown,
                          // 29:Scaffold, 30:ScrollView
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
    columns: int
    active_index: int
    badge_count: int
    is_online: bool
    options: vector[string]
    children: vector[Widget]

// Base factory to initialize defaults
fn new_widget(kind: int) -> Widget:
    let empty_ch: vector[Widget] = []
    let empty_opts: vector[string] = []
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
        columns = 0,
        active_index = 0,
        badge_count = 0,
        is_online = false,
        options = empty_opts,
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

// Avatar / CircleAvatar (Flutter CircleAvatar / SwiftUI AsyncImage clipShape)
fn Avatar(initials: string = "", image_url: string = "", size: int = 40, is_online: bool = false, bg_color: string = "#1f6feb") -> Widget:
    let mut w: Widget = new_widget(27)
    w.text = initials
    w.image_url = image_url
    w.width = size
    w.height = size
    w.is_online = is_online
    w.bg_color = bg_color
    w.border_radius = size / 2
    return w

// --- Layout & Container Widgets ---

// Column / VStack (Flutter Column / SwiftUI VStack)
fn Column(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    let mut w: Widget = new_widget(3)
    w.children = children
    w.spacing = spacing
    w.padding = padding
    return w

fn VStack(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    return Column(children, spacing, padding)

// Row / HStack (Flutter Row / SwiftUI HStack)
fn Row(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    let mut w: Widget = new_widget(4)
    w.children = children
    w.spacing = spacing
    w.padding = padding
    return w

fn HStack(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    return Row(children, spacing, padding)

// ZStack / Stack (Flutter Stack / SwiftUI ZStack)
fn ZStack(children: vector[Widget], align: string = "center") -> Widget:
    let mut w: Widget = new_widget(9)
    w.children = children
    w.align = align
    return w

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

// Grid / GridView (Flutter GridView / SwiftUI LazyVGrid)
fn Grid(children: vector[Widget], columns: int = 2, spacing: int = 12) -> Widget:
    let mut w: Widget = new_widget(25)
    w.children = children
    w.columns = columns
    w.spacing = spacing
    return w

// Wrap (Flutter Wrap / SwiftUI flow layout)
fn Wrap(children: vector[Widget], spacing: int = 8) -> Widget:
    let mut w: Widget = new_widget(26)
    w.children = children
    w.spacing = spacing
    return w

// --- Navigation & App Structure Widgets ---

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

// TabItem for BottomNavigationBar
fn TabItem(label: string, icon_name: string, is_active: bool = false, badge_count: int = 0) -> Widget:
    let mut w: Widget = new_widget(21)
    w.text = label
    w.icon_name = icon_name
    w.is_checked = is_active
    w.badge_count = badge_count
    return w

// BottomNavigationBar (Flutter BottomNavigationBar / SwiftUI TabView)
fn BottomNavigationBar(items: vector[Widget], bg_color: string = "#161b22") -> Widget:
    let mut w: Widget = new_widget(20)
    w.children = items
    w.bg_color = bg_color
    return w

// FloatingActionButton (Flutter FloatingActionButton / SwiftUI floating overlay)
fn FloatingActionButton(icon_name: string, on_click: string = "", bg_color: string = "#238636") -> Widget:
    let mut w: Widget = new_widget(22)
    w.icon_name = icon_name
    w.on_click = on_click
    w.bg_color = bg_color
    w.width = 56
    w.height = 56
    w.border_radius = 28
    return w

// --- Overlay & Feedback Widgets ---

// Dialog / Modal (Flutter AlertDialog / SwiftUI .alert)
fn Dialog(title: string, content: Widget, actions: vector[Widget], bg_color: string = "#161b22") -> Widget:
    let mut w: Widget = new_widget(23)
    w.text = title
    w.bg_color = bg_color
    let mut ch: vector[Widget] = []
    ch.push(content)
    let mut i: int = 0
    while i < len(actions):
        ch.push(actions[i])
        i = i + 1
    w.children = ch
    return w

// SnackBar / Toast (Flutter SnackBar / SwiftUI banner)
fn SnackBar(message: string, action_label: string = "", on_action: string = "", bg_color: string = "#21262d") -> Widget:
    let mut w: Widget = new_widget(24)
    w.text = message
    w.subtitle = action_label
    w.on_click = on_action
    w.bg_color = bg_color
    return w

// Dropdown / Picker (Flutter DropdownButton / SwiftUI Picker)
fn Dropdown(options: vector[string], selected_index: int = 0, on_change: string = "") -> Widget:
    let mut w: Widget = new_widget(28)
    w.options = options
    w.active_index = selected_index
    w.on_click = on_change
    w.bg_color = "#161b22"
    w.color = "#e6edf3"
    w.border_radius = 6
    return w

// Scaffold (Flutter Scaffold / SwiftUI WindowGroup shell)
// Children: [0]: app_bar, [1]: body, [2]: bottom_bar, [3]: fab
fn Scaffold(app_bar: Widget, body: Widget, bottom_bar: Widget, fab: Widget, bg_color: string = "#0d1117") -> Widget:
    let mut w: Widget = new_widget(29)
    w.bg_color = bg_color
    let mut ch: vector[Widget] = []
    ch.push(app_bar)
    ch.push(body)
    ch.push(bottom_bar)
    ch.push(fab)
    w.children = ch
    return w

// ScrollView (Flutter SingleChildScrollView / SwiftUI ScrollView)
fn ScrollView(child: Widget, is_horizontal: bool = false) -> Widget:
    let mut w: Widget = new_widget(30)
    w.is_checked = is_horizontal
    let mut ch: vector[Widget] = []
    ch.push(child)
    w.children = ch
    return w
