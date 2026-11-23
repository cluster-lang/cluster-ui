// ==============================================================================
// Cluster UI: Google Flutter Material 3 Native Widgets
// FilledButton, OutlinedButton, TextButton, FabExtended, SearchBar, FilterChip, NavigationDrawer
// Contributor: zk-mohammad <ZaidKhan-alamgir@proton.me>
// CCFL v2.0 Terms with copyright stewardship managed by Mohammad Zaid/cluster
// ==============================================================================

import src/core/model.cl

// 58: FilledButton (Material 3 Tonal / High-emphasis filled button)
fn FilledButton(label: string, on_click: string = "", bg_color: string = "#6750A4", text_color: string = "#ffffff") -> Widget:
    let mut w: Widget = new_widget(58)
    w.text = label
    w.on_click = on_click
    w.bg_color = bg_color
    w.color = text_color
    w.font_size = 14
    w.bold = true
    w.padding = 10
    w.border_radius = 20
    return w

// 59: OutlinedButton (Material 3 Medium-emphasis outlined button)
fn OutlinedButton(label: string, on_click: string = "", border_color: string = "#79747E", text_color: string = "#6750A4") -> Widget:
    let mut w: Widget = new_widget(59)
    w.text = label
    w.on_click = on_click
    w.border_color = border_color
    w.border_width = 1
    w.color = text_color
    w.font_size = 14
    w.bold = true
    w.padding = 10
    w.border_radius = 20
    return w

// 60: TextButton (Material 3 Low-emphasis borderless button)
fn TextButton(label: string, on_click: string = "", color: string = "#6750A4") -> Widget:
    let mut w: Widget = new_widget(60)
    w.text = label
    w.on_click = on_click
    w.color = color
    w.font_size = 14
    w.bold = true
    w.padding = 8
    return w

// 61: FabExtended (Material 3 FloatingActionButton Extended with icon and label)
fn FabExtended(label: string, icon_name: string = "add", on_click: string = "", bg_color: string = "#EADDFF", text_color: string = "#21005D") -> Widget:
    let mut w: Widget = new_widget(61)
    w.text = label
    w.icon_name = icon_name
    w.on_click = on_click
    w.bg_color = bg_color
    w.color = text_color
    w.height = 56
    w.padding = 16
    w.border_radius = 16
    return w

// 62: SearchBar (Material 3 Docked & Persistent Search Bar)
fn SearchBar(placeholder: string = "Search...", leading_icon: string = "search", on_change: string = "") -> Widget:
    let mut w: Widget = new_widget(62)
    w.placeholder = placeholder
    w.icon_name = leading_icon
    w.on_change = on_change
    w.bg_color = "#2b2930"
    w.color = "#e6edf3"
    w.height = 56
    w.border_radius = 28
    w.padding = 16
    return w

// 63: FilterChip (Material 3 Selectable Tag with checkmark)
fn FilterChip(label: string, is_selected: bool = false, on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(63)
    w.text = label
    w.is_checked = is_selected
    w.on_click = on_click
    w.bg_color = "#332d41"
    w.color = "#e6edf3"
    w.border_radius = 8
    w.padding = 8
    return w

// 64: NavigationDrawer (Material 3 Standard Navigation Drawer)
fn NavigationDrawer(header: Widget, items: vector[Widget], active_index: int = 0) -> Widget:
    let mut w: Widget = new_widget(64)
    w.active_index = active_index
    w.width = 320
    w.bg_color = "#1d1b20"
    let mut ch: vector[Widget] = []
    ch.push(header)
    let mut i: int = 0
    while i < len(items):
        ch.push(items[i])
        i = i + 1
    w.children = ch
    return w
