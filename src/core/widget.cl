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
                          // 29:Scaffold, 30:ScrollView, 31:Slider, 32:Checkbox, 33:Radio,
                          // 34:Chip, 35:CircularProgressIndicator, 36:Drawer, 37:BottomSheet,
                          // 38:ExpansionTile, 39:Alert, 40:Icon, 41:Stepper, 42:SegmentedButton,
                          // 43:Tooltip, 44:NavigationRail, 45:DataTable, 46:Rating, 47:Skeleton,
                          // 48:Breadcrumbs, 49:CodeBlock, 50:MetricCard
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
    min_value: int
    max_value: int
    on_change: string
    on_delete: string
    value_str: string
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
        min_value = 0,
        max_value = 100,
        on_change = "",
        on_delete = "",
        value_str = "",
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

fn Container(child: Widget, width: int = 0, height: int = 0, padding: int = 0, bg_color: string = "", border_radius: int = 0) -> Widget:
    return Box(child, width, height, padding, bg_color, border_radius)

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

// --- Advanced Interactive & Feedback Widgets (31-40) ---

// 31: Slider (Flutter Slider / SwiftUI Slider)
fn Slider(value: int = 50, min_value: int = 0, max_value: int = 100, on_change: string = "") -> Widget:
    let mut w: Widget = new_widget(31)
    w.value = value
    w.min_value = min_value
    w.max_value = max_value
    w.on_change = on_change
    w.color = "#238636"
    return w

// 32: Checkbox (Flutter Checkbox / SwiftUI Toggle checkbox style)
fn Checkbox(is_checked: bool = false, label: string = "", on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(32)
    w.is_checked = is_checked
    w.text = label
    w.on_click = on_click
    w.color = "#238636"
    return w

// 33: Radio (Flutter Radio / SwiftUI Picker radio style)
fn Radio(is_selected: bool = false, label: string = "", value_str: string = "", on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(33)
    w.is_checked = is_selected
    w.text = label
    w.value_str = value_str
    w.on_click = on_click
    w.color = "#238636"
    return w

// 34: Chip (Flutter Chip / SwiftUI Label Capsule)
fn Chip(label: string, icon_name: string = "", on_delete: string = "", bg_color: string = "#21262d") -> Widget:
    let mut w: Widget = new_widget(34)
    w.text = label
    w.icon_name = icon_name
    w.on_delete = on_delete
    w.bg_color = bg_color
    w.color = "#e6edf3"
    w.border_radius = 16
    return w

// 35: CircularProgressIndicator (Flutter CircularProgressIndicator / SwiftUI ProgressView)
fn CircularProgressIndicator(size: int = 32, color: string = "#58a6ff", border_width: int = 3) -> Widget:
    let mut w: Widget = new_widget(35)
    w.width = size
    w.height = size
    w.color = color
    w.border_width = border_width
    return w

// 36: Drawer (Flutter Drawer / SwiftUI NavigationSplitView)
fn Drawer(header: Widget, items: vector[Widget], bg_color: string = "#161b22") -> Widget:
    let mut w: Widget = new_widget(36)
    w.bg_color = bg_color
    let mut ch: vector[Widget] = []
    ch.push(header)
    let mut i: int = 0
    while i < len(items):
        ch.push(items[i])
        i = i + 1
    w.children = ch
    return w

// 37: BottomSheet (Flutter showModalBottomSheet / SwiftUI .sheet)
fn BottomSheet(child: Widget, is_open: bool = true, on_close: string = "", bg_color: string = "#161b22") -> Widget:
    let mut w: Widget = new_widget(37)
    w.is_checked = is_open
    w.on_click = on_close
    w.bg_color = bg_color
    let mut ch: vector[Widget] = []
    ch.push(child)
    w.children = ch
    return w

// 38: ExpansionTile / Accordion (Flutter ExpansionTile / SwiftUI DisclosureGroup)
fn ExpansionTile(title: string, children: vector[Widget], is_expanded: bool = false) -> Widget:
    let mut w: Widget = new_widget(38)
    w.text = title
    w.is_checked = is_expanded
    w.children = children
    w.bg_color = "#161b22"
    return w

// 39: Alert (Flutter AlertDialog/Banner / SwiftUI Banner)
fn Alert(title: string, message: string = "", severity: string = "info") -> Widget:
    let mut w: Widget = new_widget(39)
    w.text = title
    w.subtitle = message
    w.value_str = severity
    if severity == "success":
        w.bg_color = "#1a4627"
        w.color = "#3fb950"
    elif severity == "warning":
        w.bg_color = "#4d3800"
        w.color = "#d29922"
    elif severity == "error":
        w.bg_color = "#490202"
        w.color = "#f85149"
    else:
        w.bg_color = "#162033"
        w.color = "#58a6ff"
    w.border_radius = 8
    w.padding = 12
    return w

// 40: Icon (Flutter Icon / SwiftUI Image(systemName:))
fn Icon(name: string, size: int = 20, color: string = "#8b949e") -> Widget:
    let mut w: Widget = new_widget(40)
    w.icon_name = name
    w.font_size = size
    w.color = color
    return w

// --- Phase 4 Advanced Enterprise & Productivity Widgets (41-50) ---

// 41: Stepper (Flutter Stepper / SwiftUI Stepper)
fn Stepper(label: string = "", value: int = 1, min_value: int = 0, max_value: int = 100, on_change: string = "") -> Widget:
    let mut w: Widget = new_widget(41)
    w.text = label
    w.value = value
    w.min_value = min_value
    w.max_value = max_value
    w.on_change = on_change
    w.color = "#58a6ff"
    w.bg_color = "#161b22"
    return w

// 42: SegmentedButton (Flutter SegmentedButton / SwiftUI Picker.segmented)
fn SegmentedButton(options: vector[string], active_index: int = 0, on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(42)
    w.options = options
    w.active_index = active_index
    w.on_click = on_click
    w.color = "#58a6ff"
    w.bg_color = "#21262d"
    return w

// 43: Tooltip (Flutter Tooltip / SwiftUI .help)
fn Tooltip(message: string, child: Widget) -> Widget:
    let mut w: Widget = new_widget(43)
    w.text = message
    let mut ch: vector[Widget] = []
    ch.push(child)
    w.children = ch
    return w

// 44: NavigationRail (Flutter NavigationRail / SwiftUI Sidebar)
fn NavigationRail(header: Widget, items: vector[Widget], active_index: int = 0, width: int = 220, bg_color: string = "#161b22") -> Widget:
    let mut w: Widget = new_widget(44)
    w.active_index = active_index
    w.width = width
    w.bg_color = bg_color
    let mut ch: vector[Widget] = []
    ch.push(header)
    let mut i: int = 0
    while i < len(items):
        ch.push(items[i])
        i = i + 1
    w.children = ch
    return w

// 45: DataTable (Flutter DataTable / HTML Table / SwiftUI Table)
fn DataTable(headers: vector[string], rows: vector[Widget], bg_color: string = "#161b22") -> Widget:
    let mut w: Widget = new_widget(45)
    w.options = headers
    w.children = rows
    w.bg_color = bg_color
    w.border_color = "#30363d"
    return w

// 46: Rating (Flutter RatingBar / SwiftUI Star Rating)
fn Rating(value: int = 5, max_value: int = 5, color: string = "#f1e05a", font_size: int = 18) -> Widget:
    let mut w: Widget = new_widget(46)
    w.value = value
    w.max_value = max_value
    w.color = color
    w.font_size = font_size
    return w

// 47: Skeleton (Flutter Skeleton/Shimmer / SwiftUI Redacted Placeholder)
fn Skeleton(width: int = 120, height: int = 20, border_radius: int = 4, bg_color: string = "#21262d") -> Widget:
    let mut w: Widget = new_widget(47)
    w.width = width
    w.height = height
    w.border_radius = border_radius
    w.bg_color = bg_color
    return w

// 48: Breadcrumbs (Flutter / SwiftUI / Web Navigation Path)
fn Breadcrumbs(items: vector[string], color: string = "#58a6ff") -> Widget:
    let mut w: Widget = new_widget(48)
    w.options = items
    w.color = color
    return w

// 49: CodeBlock (Flutter HighlightView / SwiftUI Monospaced Code Box)
fn CodeBlock(code: string, language: string = "cluster", bg_color: string = "#0d1117") -> Widget:
    let mut w: Widget = new_widget(49)
    w.text = code
    w.value_str = language
    w.bg_color = bg_color
    w.color = "#e6edf3"
    w.border_radius = 8
    w.padding = 12
    return w

// 50: MetricCard (Flutter KPI Card / SwiftUI Health Stat View)
fn MetricCard(title: string, value: string, delta: string = "", is_positive: bool = true, icon_name: string = "activity", color: string = "#58a6ff") -> Widget:
    let mut w: Widget = new_widget(50)
    w.text = title
    w.value_str = value
    w.subtitle = delta
    w.is_checked = is_positive
    w.icon_name = icon_name
    w.color = color
    w.bg_color = "#161b22"
    w.border_radius = 10
    w.padding = 16
    return w
