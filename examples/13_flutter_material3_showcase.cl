// ==============================================================================
// Cluster UI Example 13: Google Flutter Material 3 Design System Showcase
// Demonstrates Complete Material 3 Component Parity & Multiplatform Export
// Contributor: zk-mohammad <ZaidKhan-alamgir@proton.me>
// CCFL v2.0 Terms with copyright stewardship managed by Mohammad Zaid/cluster
// ==============================================================================

import src/ui.cl

fn build_material3_app() -> Widget:
    // 1. Search Bar
    let search = SearchBar("Search packages, widgets and docs...", "search")

    // 2. Filter Chips Row
    let chip1 = FilterChip("Material 3", true)
    let chip2 = FilterChip("Declarative", true)
    let chip3 = FilterChip("Zero VDOM", false)
    let chip4 = FilterChip("LLVM Native", true)
    let chips_row = Row([chip1, chip2, chip3, chip4], 8)

    // 3. Material 3 Buttons Row
    let btn_filled = FilledButton("Filled Button", "onFilledClick()")
    let btn_outlined = OutlinedButton("Outlined", "onOutlinedClick()")
    let btn_text = TextButton("Text Action", "onTextClick()")
    let buttons_row = Row([btn_filled, btn_outlined, btn_text], 12)

    // 4. Extended Floating Action Button
    let fab = FabExtended("Compose Module", "add", "onComposeClick()")

    // 5. Metric Cards
    let kpi1 = MetricCard("Material Coverage", "100%", "Flutter M3 Specs", true, "palette", "#6750A4")
    let kpi2 = MetricCard("Render Target", "3 Platforms", "Web + Android + iOS", true, "devices", "#007AFF")
    let kpi_row = Row([kpi1, kpi2], 12)

    // 6. Section Card
    let content = Column([
        Text("⚡ Google Flutter Material 3 Parity", 22, "#ffffff", true),
        Text("Pure Cluster Native Implementation — Zero Flutter Engine / Zero Dart VM", 13, "#8b949e"),
        Divider("#30363d", 1),
        search,
        chips_row,
        Divider("#30363d", 1),
        Text("Interactive M3 Button Suite", 16, "#e6edf3", true),
        buttons_row,
        Divider("#30363d", 1),
        kpi_row,
        Center(fab)
    ], 16, 20)

    let main_card = Card(content, "#161b22", 16, 24)

    return Column([main_card], 20, 20)

fn main() -> int:
    print("================================================================================")
    print("       ⚡ CLUSTER UI: GOOGLE FLUTTER MATERIAL 3 SHOWCASE                        ")
    print("================================================================================")

    let app: Widget = build_material3_app()

    // 1. Render to Web HTML5
    let html: string = render_page_html("Flutter Material 3 - Cluster UI", app)
    print("✔ HTML5 Rendered: " + str(len(html)) + " bytes")

    // 2. Render to Native Android Layout XML
    let xml: string = render_activity_layout_xml(app)
    print("✔ Android XML Rendered: " + str(len(xml)) + " bytes")

    // 3. Render to Apple SwiftUI View
    let swift: string = render_swiftui_view("Material3ShowcaseView", app)
    print("✔ SwiftUI View Rendered: " + str(len(swift)) + " bytes")

    if len(html) == 0 or len(xml) == 0 or len(swift) == 0:
        print("FAIL: One of the render outputs was empty.")
        sys_exit(1)

    print("--------------------------------------------------------------------------------")
    print("✔ All 3 platform targets verified successfully for Flutter Material 3!")
    print("================================================================================")
    return 0
