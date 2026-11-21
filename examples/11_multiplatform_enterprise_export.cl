// ==============================================================================
// 11. Multi-Platform Triple-Engine Export
// Exporting 50-Widget Dashboard to HTML5 Web, Android Layout XML, and Apple SwiftUI
// Pure Cluster Language — Zero External Runtimes
// ==============================================================================

import src/ui.cl

fn build_feature_suite() -> Widget:
    let crumbs: Widget = Breadcrumbs(["App", "Telemetry", "50 Widgets", "Export"])

    let stat: Widget = MetricCard(
        title = "Triple-Engine Native Export",
        value = "100% Native",
        delta = "Web HTML5 + Android XML + Apple SwiftUI",
        is_positive = true,
        icon_name = "share",
        color = "#58a6ff"
    )

    let seg: Widget = SegmentedButton(["Web (HTML5)", "Android (XML)", "Apple (SwiftUI)"], 0)
    let step: Widget = Stepper("Scale Factor", 2, 1, 4)
    let rate: Widget = Rating(5, 5)

    let code_snippet: Widget = CodeBlock(
        code = "fn render_all(root: Widget):\n    let h = render_page_html(\"App\", root)\n    let a = render_activity_layout_xml(root)\n    let s = render_swiftui_view(\"AppView\", root)",
        language = "cluster"
    )

    let card_content: Widget = Column(
        children = [
            crumbs,
            Spacer(),
            stat,
            Spacer(),
            seg,
            Spacer(),
            step,
            Spacer(),
            rate,
            Spacer(),
            code_snippet
        ],
        spacing = 12
    )

    return Card(child = card_content, bg_color = "#161b22", padding = 16)

fn main():
    let root: Widget = build_feature_suite()

    pln("=== 1. HTML5 WEB TARGET ===")
    let html_code: string = render_page_html("Cluster UI Multi-Platform", root)
    pln(html_code)

    pln("\n=== 2. ANDROID JETPACK / XML TARGET ===")
    let android_xml: string = render_activity_layout_xml(root)
    pln(android_xml)

    pln("\n=== 3. APPLE SWIFTUI TARGET ===")
    let swiftui_code: string = render_swiftui_view("ClusterEnterpriseView", root)
    pln(swiftui_code)
