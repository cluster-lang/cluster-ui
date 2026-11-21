// ==============================================================================
// Cluster UI: Layout Widgets
// Column/VStack, Row/HStack, Box/Container, Stack/ZStack, Grid, Wrap, Scaffold, ScrollView, Expanded
// ==============================================================================

import src/core/model.cl

// Column (Flutter Column / SwiftUI VStack)
fn Column(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    let mut w: Widget = new_widget(3)
    w.children = children
    w.spacing = spacing
    w.padding = padding
    return w

fn VStack(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    return Column(children, spacing, padding)

// Row (Flutter Row / SwiftUI HStack)
fn Row(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    let mut w: Widget = new_widget(4)
    w.children = children
    w.spacing = spacing
    w.padding = padding
    return w

fn HStack(children: vector[Widget], spacing: int = 8, padding: int = 0) -> Widget:
    return Row(children, spacing, padding)

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

// ZStack / Stack (Flutter Stack / SwiftUI ZStack)
fn ZStack(children: vector[Widget], align: string = "center") -> Widget:
    let mut w: Widget = new_widget(9)
    w.children = children
    w.align = align
    return w

fn Stack(children: vector[Widget], align: string = "center") -> Widget:
    return ZStack(children, align)

// Grid (Flutter GridView / SwiftUI LazyVGrid)
fn Grid(children: vector[Widget], columns: int = 2, spacing: int = 8) -> Widget:
    let mut w: Widget = new_widget(25)
    w.children = children
    w.columns = columns
    w.spacing = spacing
    return w

// Wrap (Flutter Wrap / SwiftUI FlowLayout)
fn Wrap(children: vector[Widget], spacing: int = 8) -> Widget:
    let mut w: Widget = new_widget(26)
    w.children = children
    w.spacing = spacing
    return w

// Expanded (Flutter Expanded / SwiftUI frame(maxWidth: .infinity))
fn Expanded(child: Widget, flex: int = 1) -> Widget:
    let mut w: Widget = new_widget(18)
    let mut ch: vector[Widget] = []
    ch.push(child)
    w.children = ch
    w.flex = flex
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
