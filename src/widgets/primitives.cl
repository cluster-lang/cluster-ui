// ==============================================================================
// Cluster UI: Primitive & Content Widgets
// Text, Button, Image, Icon, Badge, Link, Divider, Spacer, Center
// ==============================================================================

import src/core/model.cl

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

// Image (Flutter Image.network / SwiftUI Image)
fn Image(url: string, width: int = 0, height: int = 0, border_radius: int = 0, alt: string = "") -> Widget:
    let mut w: Widget = new_widget(8)
    w.image_url = url
    w.width = width
    w.height = height
    w.border_radius = border_radius
    w.text = alt
    return w

// Badge (Flutter Chip / SwiftUI Badge)
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

// Link (HTML <a> / SwiftUI Link)
fn Link(label: string, url: string, color: string = "#58a6ff", font_size: int = 14) -> Widget:
    let mut w: Widget = new_widget(17)
    w.text = label
    w.url = url
    w.color = color
    w.font_size = font_size
    return w

// Divider (Flutter Divider / SwiftUI Divider)
fn Divider(color: string = "#30363d", height: int = 1) -> Widget:
    let mut w: Widget = new_widget(10)
    w.color = color
    w.height = height
    return w

// Spacer (Flutter Spacer / SwiftUI Spacer)
fn Spacer(flex: int = 1) -> Widget:
    let mut w: Widget = new_widget(6)
    w.flex = flex
    return w

// Center (Flutter Center / SwiftUI Center)
fn Center(child: Widget) -> Widget:
    let mut w: Widget = new_widget(16)
    let mut ch: vector[Widget] = []
    ch.push(child)
    w.children = ch
    return w

// Icon (Flutter Icon / SwiftUI Image(systemName:))
fn Icon(name: string, size: int = 20, color: string = "#8b949e") -> Widget:
    let mut w: Widget = new_widget(40)
    w.icon_name = name
    w.font_size = size
    w.color = color
    return w

// RawHtml / Custom Component (Flutter HtmlElementView / SwiftUI UIViewRepresentable)
fn RawHtml(html_content: string) -> Widget:
    let mut w: Widget = new_widget(51)
    w.text = html_content
    return w
