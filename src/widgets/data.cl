// ==============================================================================
// Cluster UI: Data Display & Content Presentation Widgets
// Card, ListTile, Avatar, Chip, DataTable, CodeBlock, MetricCard
// Pure Cluster Language — 100% Zero Dependencies
// ==============================================================================

import src/core/model.cl

// 11: Card (Flutter Card / SwiftUI GroupBox)
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

// 15: ListTile (Flutter ListTile / SwiftUI NavigationLink label)
fn ListTile(title: string, subtitle: string = "", icon_name: string = "", on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(15)
    w.text = title
    w.subtitle = subtitle
    w.icon_name = icon_name
    w.on_click = on_click
    return w

// 27: Avatar / CircleAvatar (Flutter CircleAvatar / SwiftUI AsyncImage clipShape)
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

// 45: DataTable (Flutter DataTable / HTML Table / SwiftUI Table)
fn DataTable(headers: vector[string], rows: vector[Widget], bg_color: string = "#161b22") -> Widget:
    let mut w: Widget = new_widget(45)
    w.options = headers
    w.children = rows
    w.bg_color = bg_color
    w.border_color = "#30363d"
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
