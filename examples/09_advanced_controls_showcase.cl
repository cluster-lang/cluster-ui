// ==============================================================================
// 09. Advanced Controls & Interactive Feedback Showcase
// Rebuilding Flutter Material 3 & Apple SwiftUI Advanced Components in Pure Cluster
// ==============================================================================

import src/core/widget.cl
import src/render/html.cl

fn build_advanced_app() -> Widget:
    // Header Banner Alert
    let alert_box: Widget = Alert(
        title = "Cloud Cluster Synchronization Active",
        message = "All widgets are live-synced across HTML5, Android Jetpack, and Apple SwiftUI.",
        severity = "success"
    )

    // Interactive Controls Section
    let form_title: Widget = Text("Interactive Controls & Form Primitives", 18, "#58a6ff", true)

    let chk1: Widget = Checkbox(is_checked = true, label = "Hardware Acceleration (Vulkan / Metal)")
    let chk2: Widget = Checkbox(is_checked = false, label = "Experimental JIT Optimization")

    let r_option1: Widget = Radio(is_selected = true, label = "Dark Neon Theme (Default)", value_str = "dark_neon")
    let r_option2: Widget = Radio(is_selected = false, label = "Material You Theme", value_str = "material_you")

    let slider_label: Widget = Text("Execution Thread Pool Size: 8 Threads", 14, "#e6edf3", false)
    let thread_slider: Widget = Slider(value = 64, min_value = 1, max_value = 128, on_change = "console.log(this.value)")

    let controls_card: Widget = Card(
        child = Column(
            children = [
                form_title,
                Spacer(),
                chk1,
                chk2,
                Divider(),
                r_option1,
                r_option2,
                Divider(),
                slider_label,
                thread_slider
            ],
            spacing = 10,
            padding = 16
        )
    )

    // Chips & Badges Section
    let chip_title: Widget = Text("Filter & Category Chips", 16, "#e6edf3", true)
    let c1: Widget = Chip(label = "Performance", icon_name = "bolt", on_delete = "alert('removed')", bg_color = "#238636")
    let c2: Widget = Chip(label = "Cross-Platform", icon_name = "globe", on_delete = "", bg_color = "#1f6feb")
    let c3: Widget = Chip(label = "Native LLVM", icon_name = "cpu", on_delete = "", bg_color = "#8957e5")
    let c4: Widget = Chip(label = "Zero-Cost", icon_name = "zap", on_delete = "", bg_color = "#d29922")
    let chips_row: Widget = Wrap(children = [c1, c2, c3, c4], spacing = 8)

    // Expandable Details (Accordion / ExpansionTile)
    let exp_content1: Widget = Text("Cluster compiler compiles directly from high-level Pratt AST into SSA LLVM IR in ~3ms.", 13, "#8b949e", false)
    let exp_content2: Widget = Text("Native binary generation takes ~40ms using Clang and GNU ld with zero runtime GC pauses.", 13, "#8b949e", false)
    let accordion: Widget = ExpansionTile(
        title = "Compiler Architecture Deep Dive",
        children = [exp_content1, exp_content2],
        is_expanded = true
    )

    // Progress & Activity Row
    let prog_label: Widget = Text("Asset Pipeline Compilation", 14, "#e6edf3", false)
    let spinner: Widget = CircularProgressIndicator(size = 24, color = "#58a6ff", border_width = 3)
    let prog_row: Widget = Row(children = [spinner, prog_label], spacing = 12, padding = 4)

    // Bottom Navigation Bar
    let nav_home: Widget = TabItem("Dashboard", "home", true, 0)
    let nav_widgets: Widget = TabItem("Components", "layers", false, 40)
    let nav_settings: Widget = TabItem("Settings", "settings", false, 0)
    let bbar: Widget = BottomNavigationBar(items = [nav_home, nav_widgets, nav_settings])

    let main_col: Widget = Column(
        children = [
            alert_box,
            controls_card,
            chip_title,
            chips_row,
            accordion,
            prog_row
        ],
        spacing = 16,
        padding = 16
    )

    let scrollable_body: Widget = ScrollView(child = main_col)

    let app_bar_header: Widget = AppBar(
        title = "Cluster UI — 40 Core Widgets",
        leading = Icon(name = "menu", size = 20, color = "#e6edf3"),
        trailing = Icon(name = "bell", size = 20, color = "#58a6ff")
    )

    let fab_btn: Widget = FloatingActionButton(icon_name = "+", on_click = "alert('Action clicked!')", bg_color = "#238636")

    return Scaffold(
        app_bar = app_bar_header,
        body = scrollable_body,
        bottom_bar = bbar,
        fab = fab_btn,
        bg_color = "#0d1117"
    )

fn main() -> int:
    let app: Widget = build_advanced_app()
    let html: string = render_page_html("Cluster UI - Advanced Controls", app)
    pln(html)
    return 0
