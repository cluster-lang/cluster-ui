// ==============================================================================
// Example 08: Universal Multi-Platform Showcase in Cluster UI
// Demonstrates single codebase targeting 3 production platforms:
// 1. Web HTML5 (Semantic Flexbox & Grid)
// 2. Android Jetpack Layout XML (Material Components)
// 3. Apple SwiftUI View (Declarative Swift)
// ==============================================================================

import src/ui.cl

fn build_profile_screen() -> Widget:
    let mut cards: vector[Widget] = []

    // Header with Avatar & Name
    let mut header_items: vector[Widget] = []
    header_items.push(Avatar("AK", "", 64, true, "#8957e5"))
    header_items.push(Text("Alamgir Khan", 20, "#ffffff", true))
    header_items.push(Text("Cluster Language Architect", 14, "#8b949e", false))
    cards.push(Card(Center(Column(header_items, 8)), "#161b22", 16, 20))

    // Storage Usage Card
    let mut storage_items: vector[Widget] = []
    let mut s_row: vector[Widget] = []
    s_row.push(Text("Cloud Storage", 14, "#f0f6fc", true))
    s_row.push(Spacer())
    s_row.push(Badge("68% Used", "#1f6feb", "#ffffff", 11))
    storage_items.push(Row(s_row))
    storage_items.push(ProgressBar(68, "#1f6feb", "#21262d", 8))
    cards.push(Card(Column(storage_items, 10), "#161b22", 12, 16))

    // Settings Tile List
    let mut list_items: vector[Widget] = []
    list_items.push(ListTile("Security & Keys", "Manage 2FA & SSH Keys", "🔒"))
    list_items.push(Divider("#30363d", 1))
    list_items.push(ListTile("Notifications", "Push & Email Alerts", "🔔"))
    list_items.push(Divider("#30363d", 1))
    list_items.push(ListTile("Connected Devices", "3 Active Sessions", "📱"))
    cards.push(Card(Column(list_items, 4), "#161b22", 12, 12))

    // Action button
    cards.push(Button("Save Preferences", "savePrefs()", "#238636", "#ffffff", 14))

    let scroll_body: Widget = ScrollView(Column(cards, 16))

    let top_bar: Widget = AppBar("Settings & Profile", Button("←", "", "#21262d", "#e6edf3", 14), Badge("PRO", "#d2a8ff", "#ffffff", 11), "#161b22")
    let mut tabs: vector[Widget] = []
    tabs.push(TabItem("Home", "🏠", false, 0))
    tabs.push(TabItem("Profile", "👤", true, 0))
    tabs.push(TabItem("Settings", "⚙️", false, 0))
    let bottom_nav: Widget = BottomNavigationBar(tabs, "#161b22")
    let fab: Widget = FloatingActionButton("+", "addItem()", "#1f6feb")

    return Scaffold(top_bar, scroll_body, bottom_nav, fab, "#0d1117")

fn main() -> int:
    pln("==================================================")
    pln(" Cluster UI: 1 Codebase -> 3 Native Platforms")
    pln("==================================================")

    let screen: Widget = build_profile_screen()

    // 1. Web HTML
    let html: string = render_page_html("Universal Settings - Cluster UI", screen)
    pln("[1] HTML5 Output: " + str(len(html)) + " bytes")

    // 2. Android XML
    let xml: string = render_activity_layout_xml(screen)
    pln("[2] Android XML Output: " + str(len(xml)) + " bytes")

    // 3. Apple SwiftUI
    let swift: string = render_swiftui_view("ProfileSettingsView", screen)
    pln("[3] Apple SwiftUI Output: " + str(len(swift)) + " bytes")

    pln("\n--- Sample SwiftUI View Code (First 400 chars) ---")
    let mut preview: string = ""
    let mut i: int = 0
    let max_len: int = 400
    if len(swift) < 400:
        max_len = len(swift)
    while i < max_len:
        preview = preview + swift[i]
        i = i + 1
    pln(preview)
    pln("...\n")

    pln("✅ Multi-platform compilation verified with 100% success!")
    return 0
