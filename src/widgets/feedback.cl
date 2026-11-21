// ==============================================================================
// Cluster UI: Feedback, Dialog & Overlay Widgets
// ProgressBar, CircularProgressIndicator, Alert, SnackBar, Dialog, BottomSheet, Drawer, ExpansionTile, Skeleton, Rating, Tooltip
// ==============================================================================

import src/core/model.cl

// ProgressBar (Flutter LinearProgressIndicator / SwiftUI ProgressView)
fn ProgressBar(progress: int, color: string = "#238636", height: int = 8) -> Widget:
    let mut w: Widget = new_widget(14)
    w.value = progress
    w.color = color
    w.height = height
    w.bg_color = "#21262d"
    w.border_radius = 4
    return w

// CircularProgressIndicator (Flutter CircularProgressIndicator / SwiftUI ProgressView)
fn CircularProgressIndicator(size: int = 32, color: string = "#58a6ff", border_width: int = 3) -> Widget:
    let mut w: Widget = new_widget(35)
    w.width = size
    w.height = size
    w.color = color
    w.border_width = border_width
    return w

// Alert (Flutter AlertDialog/Banner / SwiftUI Banner)
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

// SnackBar / Toast (Flutter SnackBar / SwiftUI banner)
fn SnackBar(message: string, action_label: string = "", on_action: string = "", bg_color: string = "#21262d") -> Widget:
    let mut w: Widget = new_widget(24)
    w.text = message
    w.subtitle = action_label
    w.on_click = on_action
    w.bg_color = bg_color
    w.color = "#ffffff"
    w.padding = 12
    w.border_radius = 6
    return w

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
    w.border_radius = 12
    w.padding = 20
    return w

// Drawer (Flutter Drawer / SwiftUI NavigationSplitView)
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

// BottomSheet (Flutter showModalBottomSheet / SwiftUI .sheet)
fn BottomSheet(child: Widget, is_open: bool = true, on_close: string = "", bg_color: string = "#161b22") -> Widget:
    let mut w: Widget = new_widget(37)
    w.is_checked = is_open
    w.on_click = on_close
    w.bg_color = bg_color
    let mut ch: vector[Widget] = []
    ch.push(child)
    w.children = ch
    return w

// ExpansionTile / Accordion (Flutter ExpansionTile / SwiftUI DisclosureGroup)
fn ExpansionTile(title: string, children: vector[Widget], is_expanded: bool = false) -> Widget:
    let mut w: Widget = new_widget(38)
    w.text = title
    w.is_checked = is_expanded
    w.children = children
    w.bg_color = "#161b22"
    return w

// Skeleton (Flutter Skeleton/Shimmer / SwiftUI Redacted Placeholder)
fn Skeleton(width: int = 120, height: int = 20, border_radius: int = 4, bg_color: string = "#21262d") -> Widget:
    let mut w: Widget = new_widget(47)
    w.width = width
    w.height = height
    w.border_radius = border_radius
    w.bg_color = bg_color
    return w

// Rating (Flutter RatingBar / SwiftUI Star Rating)
fn Rating(value: int = 5, max_value: int = 5, color: string = "#f1e05a", font_size: int = 18) -> Widget:
    let mut w: Widget = new_widget(46)
    w.value = value
    w.max_value = max_value
    w.color = color
    w.font_size = font_size
    return w

// Tooltip (Flutter Tooltip / SwiftUI .help)
fn Tooltip(message: string, child: Widget) -> Widget:
    let mut w: Widget = new_widget(43)
    w.text = message
    let mut ch: vector[Widget] = []
    ch.push(child)
    w.children = ch
    return w
