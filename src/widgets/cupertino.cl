// ==============================================================================
// Cluster UI: Apple Cupertino (iOS) Native Widgets
// CupertinoButton, CupertinoNavigationBar, CupertinoTabBar, CupertinoActionSheet,
// CupertinoSwitch, CupertinoPicker, CupertinoSegmentedControl
// Contributor: zk-mohammad <ZaidKhan-alamgir@proton.me>
// CCFL v2.0 Terms with copyright stewardship managed by Mohammad Zaid/cluster
// ==============================================================================

import src/core/model.cl

// 51: CupertinoButton (iOS rounded filled/tinted button with iOS tap haptics)
fn CupertinoButton(label: string, on_click: string = "", is_filled: bool = true, bg_color: string = "#007AFF") -> Widget:
    let mut w: Widget = new_widget(51)
    w.text = label
    w.on_click = on_click
    w.is_checked = is_filled
    w.bg_color = bg_color
    w.color = "#ffffff"
    w.font_size = 16
    w.border_radius = 8
    w.padding = 12
    return w

// 52: CupertinoNavigationBar (iOS Frosted Glass Navigation Bar)
fn CupertinoNavigationBar(title: string, leading: Widget, trailing: Widget, bg_color: string = "rgba(22, 27, 34, 0.8)") -> Widget:
    let mut w: Widget = new_widget(52)
    w.text = title
    w.bg_color = bg_color
    let mut ch: vector[Widget] = []
    ch.push(leading)
    ch.push(trailing)
    w.children = ch
    return w

// 53: CupertinoTabBar (iOS Blurred Bottom Tab Bar)
fn CupertinoTabBar(items: vector[Widget], active_index: int = 0) -> Widget:
    let mut w: Widget = new_widget(53)
    w.children = items
    w.active_index = active_index
    w.bg_color = "rgba(22, 27, 34, 0.85)"
    return w

// 54: CupertinoActionSheet (iOS Modal Action Sheet)
fn CupertinoActionSheet(title: string, message: string, actions: vector[Widget], cancel_label: string = "Cancel", on_cancel: string = "") -> Widget:
    let mut w: Widget = new_widget(54)
    w.text = title
    w.subtitle = message
    w.value_str = cancel_label
    w.on_click = on_cancel
    w.children = actions
    w.bg_color = "#1c1c1e"
    w.border_radius = 14
    return w

// 55: CupertinoSwitch (iOS Fluid Green Toggle)
fn CupertinoSwitch(is_on: bool = false, on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(55)
    w.is_checked = is_on
    w.on_click = on_click
    w.bg_color = "#34C759"
    return w

// 56: CupertinoPicker (iOS Wheel Picker)
fn CupertinoPicker(options: vector[string], selected_index: int = 0, on_change: string = "") -> Widget:
    let mut w: Widget = new_widget(56)
    w.options = options
    w.active_index = selected_index
    w.on_change = on_change
    w.height = 180
    w.bg_color = "#1c1c1e"
    return w

// 57: CupertinoSegmentedControl (iOS Pill Segmented Selector)
fn CupertinoSegmentedControl(options: vector[string], active_index: int = 0, on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(57)
    w.options = options
    w.active_index = active_index
    w.on_click = on_click
    w.bg_color = "#767680"
    w.color = "#ffffff"
    w.border_radius = 8
    return w
