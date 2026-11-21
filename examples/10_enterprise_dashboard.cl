// ==============================================================================
// 10. Enterprise Dashboard & Analytics Suite
// Showcasing Cluster UI Widgets 1 to 50:
// MetricCard, DataTable, SegmentedButton, Stepper, Rating, Skeleton,
// Breadcrumbs, CodeBlock, Tooltip, and Multiplatform Rendering
// ==============================================================================

import src/core/widget.cl
import src/render/html.cl

fn build_enterprise_dashboard() -> Widget:
    // 1. Breadcrumbs Navigation
    let breadcrumb_trail: Widget = Breadcrumbs(
        items = ["Cluster Cloud", "Workspaces", "Compiler Cluster", "Realtime Metrics"],
        color = "#58a6ff"
    )

    // 2. KPI Metric Cards Row
    let card1: Widget = MetricCard(
        title = "Compile & Run Latency",
        value = "49.5 ms",
        delta = "+140% faster than v1",
        is_positive = true,
        icon_name = "zap",
        color = "#3fb950"
    )

    let card2: Widget = MetricCard(
        title = "Memory Overhead",
        value = "0.0 MB",
        delta = "Zero-GC Deterministic",
        is_positive = true,
        icon_name = "cpu",
        color = "#58a6ff"
    )

    let card3: Widget = MetricCard(
        title = "Worker Throughput",
        value = "128,400 ops/s",
        delta = "+38.2% vs Swift/Dart",
        is_positive = true,
        icon_name = "activity",
        color = "#a371f7"
    )

    let card4: Widget = MetricCard(
        title = "System Health",
        value = "99.99%",
        delta = "All 50 UI Primitives Online",
        is_positive = true,
        icon_name = "shield",
        color = "#d29922"
    )

    let metrics_row: Widget = Row(
        children = [card1, card2, card3, card4],
        spacing = 16
    )

    // 3. Interactive Toolbar: Timeframe Selector & Node Stepper
    let timeframe_selector: Widget = SegmentedButton(
        options = ["Live", "1 Hour", "24 Hours", "7 Days"],
        active_index = 0
    )

    let scale_stepper: Widget = Stepper(
        label = "Worker Nodes:",
        value = 16,
        min_value = 1,
        max_value = 64
    )

    let user_rating: Widget = Rating(
        value = 5,
        max_value = 5,
        color = "#f1e05a",
        font_size = 18
    )

    let control_bar: Widget = Row(
        children = [
            timeframe_selector,
            Spacer(),
            scale_stepper,
            Spacer(),
            Row(children = [Text("Score:", 13, "#8b949e"), user_rating], spacing = 8)
        ],
        spacing = 16
    )

    // 4. Analytics Data Table
    let table_headers: vector[string] = ["Compiler Pipeline Stage", "Target Backend", "Latency", "Optimization Level", "Verification"]

    let row1_cells: vector[Widget] = [
        Text("Pratt AST Parsing", 13, "#e6edf3", true),
        Text("Memory IR", 13, "#8b949e"),
        Text("0.38 ms", 13, "#3fb950"),
        Badge("High", "#1f6feb"),
        Text("PASSED [100%]", 13, "#3fb950", true)
    ]
    let row1: Widget = Row(children = row1_cells, spacing = 8)

    let row2_cells: vector[Widget] = [
        Text("SSA LLVM Emission", 13, "#e6edf3", true),
        Text("LLVM IR (Zero-Regex)", 13, "#8b949e"),
        Text("0.39 ms", 13, "#3fb950"),
        Badge("O3", "#238636"),
        Text("PASSED [100%]", 13, "#3fb950", true)
    ]
    let row2: Widget = Row(children = row2_cells, spacing = 8)

    let row3_cells: vector[Widget] = [
        Text("Native Machine Code Link", 13, "#e6edf3", true),
        Text("Clang x86_64 / AArch64", 13, "#8b949e"),
        Text("42.1 ms", 13, "#3fb950"),
        Badge("Release", "#8957e5"),
        Text("PASSED [100%]", 13, "#3fb950", true)
    ]
    let row3: Widget = Row(children = row3_cells, spacing = 8)

    let data_table: Widget = DataTable(
        headers = table_headers,
        rows = [row1, row2, row3]
    )

    // 5. Code Block Showcase
    let sample_code: string = "// Pure Cluster UI Component\nfn StatusBadge(active: bool) -> Widget:\n    if active:\n        return Badge(\"ONLINE\", \"#238636\")\n    return Badge(\"OFFLINE\", \"#da3633\")"
    let code_viewer: Widget = CodeBlock(
        code = sample_code,
        language = "cluster"
    )

    // 6. Asynchronous Shimmer/Skeleton Status
    let skeleton_box: Widget = Row(
        children = [
            Text("Syncing Background Telemetry:", 13, "#8b949e"),
            Skeleton(width = 180, height = 16, border_radius = 4),
            Skeleton(width = 80, height = 16, border_radius = 4)
        ],
        spacing = 12
    )

    // Assemble Full View
    let content: Widget = Column(
        children = [
            breadcrumb_trail,
            Spacer(),
            metrics_row,
            Spacer(),
            control_bar,
            Spacer(),
            Text("Core Performance Verification Ledger", 16, "#e6edf3", true),
            data_table,
            Spacer(),
            Text("Declarative Component Implementation", 16, "#e6edf3", true),
            code_viewer,
            Spacer(),
            skeleton_box
        ],
        spacing = 14
    )

    let leading_btn: Widget = Icon("cpu", 20, "#58a6ff")
    let trailing_btn: Widget = Icon("bell", 20, "#58a6ff")
    let app_bar: Widget = AppBar(
        title = "Cluster UI v4.0 — 50 Core Widgets Enterprise Suite",
        leading = leading_btn,
        trailing = trailing_btn,
        bg_color = "#161b22"
    )

    let nav_items: vector[Widget] = [
        TabItem("Overview", "home", true, 0),
        TabItem("Telemetry", "activity", false, 50),
        TabItem("Components", "layers", false, 0),
        TabItem("Config", "settings", false, 0)
    ]
    let bottom_nav: Widget = BottomNavigationBar(items = nav_items)

    let fab: Widget = FloatingActionButton("+", "alert('Cluster node created!')")

    let page: Widget = Scaffold(
        app_bar = app_bar,
        body = ScrollView(child = Box(content, 0, 0, 20, "#0d1117", 0)),
        bottom_bar = bottom_nav,
        fab = fab
    )
    return page

fn main():
    let app: Widget = build_enterprise_dashboard()
    let html_output: string = render_page_html("Cluster UI - 50 Widgets Enterprise Dashboard", app)
    pln(html_output)
