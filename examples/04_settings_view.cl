// ==============================================================================
// Cluster UI Example 04: System Settings View
// Demonstrates: AppBar, ListTile, Toggle, TextInput, Divider, Card, Button
// ==============================================================================

import src/core/widget.cl
import src/render/html.cl

fn main() -> int:
    // Settings Group 1: General
    let mut general_items: vector[Widget] = []
    general_items.push(Text("System Preferences", 16, "#e6edf3", true))
    general_items.push(Divider("#30363d", 1))
    general_items.push(Toggle(true, "Hardware Acceleration (Vulkan/Metal)", "alert('Toggle Vulkan')"))
    general_items.push(Toggle(true, "LLVM Native Optimization (-O3)", "alert('Toggle O3')"))
    general_items.push(Toggle(false, "Verbose Diagnostic Tracing", "alert('Toggle Diagnostics')"))
    let general_card: Widget = Card(Column(general_items, 12, 0), "#161b22", 12, 16)

    // Settings Group 2: Account & Registry
    let mut account_items: vector[Widget] = []
    account_items.push(Text("Cluster Package Registry", 16, "#e6edf3", true))
    account_items.push(Divider("#30363d", 1))
    account_items.push(Text("Registry API Endpoint", 12, "#8b949e", false))
    account_items.push(TextInput("https://pkg.cluster-lang.org/v1", 13))

    let mut btn_row: vector[Widget] = []
    btn_row.push(Spacer())
    btn_row.push(Button("Save Settings", "alert('Settings Saved!')", "#238636", "#ffffff", 13))
    account_items.push(Row(btn_row, 8, 0))
    let account_card: Widget = Card(Column(account_items, 12, 0), "#161b22", 12, 16)

    // Layout
    let mut view_items: vector[Widget] = []
    let leading_btn: Widget = Button("‹ Back", "history.back()", "#21262d", "#58a6ff", 13)
    let trailing_btn: Widget = Badge("v1.0.0", "#30363d", "#8b949e", 11)
    let header: Widget = AppBar("Settings", leading_btn, trailing_btn, "#161b22")

    view_items.push(header)
    view_items.push(general_card)
    view_items.push(account_card)

    let root: Widget = Box(Column(view_items, 18, 0), 480, 0, 0, "", 0)
    let html_out: string = render_page_html("Cluster Settings", root)

    pln("=== Settings View Rendered Successfully ===")
    pln(html_out)
    return 0
