// ==============================================================================
// Cluster UI: Apple SwiftUI Declarative Native Views
// Form, Section, List, NavigationStack, NavigationLink, Gauge
// Contributor: zk-mohammad <ZaidKhan-alamgir@proton.me>
// CCFL v2.0 Terms with copyright stewardship managed by Mohammad Zaid/cluster
// ==============================================================================

import src/core/model.cl

// 65: Form (SwiftUI Form grouped data input container)
fn Form(children: vector[Widget]) -> Widget:
    let mut w: Widget = new_widget(65)
    w.children = children
    w.bg_color = "#000000"
    w.padding = 16
    return w

// 66: Section (SwiftUI Section with header and optional footer)
fn Section(header: string, children: vector[Widget], footer: string = "") -> Widget:
    let mut w: Widget = new_widget(66)
    w.text = header
    w.subtitle = footer
    w.children = children
    w.bg_color = "#1c1c1e"
    w.border_radius = 10
    w.padding = 12
    return w

// 67: List (SwiftUI List scrollable container)
fn List(children: vector[Widget]) -> Widget:
    let mut w: Widget = new_widget(67)
    w.children = children
    w.bg_color = "#000000"
    return w

// 68: NavigationStack (SwiftUI NavigationStack routing container)
fn NavigationStack(root_view: Widget, title: string = "") -> Widget:
    let mut w: Widget = new_widget(68)
    w.text = title
    let mut ch: vector[Widget] = []
    ch.push(root_view)
    w.children = ch
    return w

// 69: NavigationLink (SwiftUI NavigationLink destination pointer)
fn NavigationLink(label: Widget, destination_url: string = "") -> Widget:
    let mut w: Widget = new_widget(69)
    w.url = destination_url
    let mut ch: vector[Widget] = []
    ch.push(label)
    w.children = ch
    return w

// 70: Gauge (SwiftUI Gauge metric visualizer)
fn Gauge(value: int, min_value: int = 0, max_value: int = 100, label: string = "", color: string = "#007AFF") -> Widget:
    let mut w: Widget = new_widget(70)
    w.value = value
    w.min_value = min_value
    w.max_value = max_value
    w.text = label
    w.color = color
    w.bg_color = "#2c2c2e"
    w.height = 12
    return w
