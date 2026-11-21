// ==============================================================================
// Cluster UI: Navigation & Structure Widgets
// AppBar, BottomNavigationBar, TabItem, FloatingActionButton, NavigationRail, Breadcrumbs
// Pure Cluster Language — 100% Zero Dependencies
// ==============================================================================

import src/core/model.cl

// 19: AppBar / NavigationBar (Flutter AppBar / SwiftUI NavigationTitle)
fn AppBar(title: string, leading: Widget, trailing: Widget, bg_color: string = "#161b22") -> Widget:
    let mut w: Widget = new_widget(19)
    w.text = title
    w.bg_color = bg_color
    let mut ch: vector[Widget] = []
    ch.push(leading)
    ch.push(trailing)
    w.children = ch
    return w

// 21: TabItem for BottomNavigationBar
fn TabItem(label: string, icon_name: string, is_active: bool = false, badge_count: int = 0) -> Widget:
    let mut w: Widget = new_widget(21)
    w.text = label
    w.icon_name = icon_name
    w.is_checked = is_active
    w.badge_count = badge_count
    return w

// 20: BottomNavigationBar (Flutter BottomNavigationBar / SwiftUI TabView)
fn BottomNavigationBar(items: vector[Widget], bg_color: string = "#161b22") -> Widget:
    let mut w: Widget = new_widget(20)
    w.children = items
    w.bg_color = bg_color
    return w

// 22: FloatingActionButton (Flutter FloatingActionButton / SwiftUI floating overlay)
fn FloatingActionButton(icon_name: string, on_click: string = "", bg_color: string = "#238636") -> Widget:
    let mut w: Widget = new_widget(22)
    w.icon_name = icon_name
    w.on_click = on_click
    w.bg_color = bg_color
    w.width = 56
    w.height = 56
    w.border_radius = 28
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

// 48: Breadcrumbs (Flutter / SwiftUI / Web Navigation Path)
fn Breadcrumbs(items: vector[string], color: string = "#58a6ff") -> Widget:
    let mut w: Widget = new_widget(48)
    w.options = items
    w.color = color
    return w
