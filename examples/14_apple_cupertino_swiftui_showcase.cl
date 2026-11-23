// ==============================================================================
// Cluster UI Example 14: Apple Cupertino & SwiftUI Declarative Showcase
// Demonstrates Complete Cupertino (iOS) & SwiftUI Component Parity & Multiplatform Export
// Contributor: zk-mohammad <ZaidKhan-alamgir@proton.me>
// CCFL v2.0 Terms with copyright stewardship managed by Mohammad Zaid/cluster
// ==============================================================================

import src/ui.cl

fn build_cupertino_swiftui_app() -> Widget:
    // 1. Cupertino Navigation Bar
    let lead_btn = CupertinoButton("‹ Back", "history.back()", false, "#007AFF")
    let trail_btn = CupertinoButton("Done", "onDone()", true, "#007AFF")
    let nav_bar = CupertinoNavigationBar("iOS Preferences", lead_btn, trail_btn)

    // 2. Cupertino Segmented Control
    let seg_opts: vector[string] = []
    seg_opts.push("Standard")
    seg_opts.push("Cupertino")
    seg_opts.push("SwiftUI")
    let segment = CupertinoSegmentedControl(seg_opts, 1)

    // 3. Cupertino Fluid Switches
    let sw1 = CupertinoSwitch(true, "onSyncToggle()")
    let sw2 = CupertinoSwitch(false, "onHapticsToggle()")
    let switch_row1 = Row([Text("iCloud CloudKit Sync", 15, "#ffffff"), Spacer(), sw1], 10)
    let switch_row2 = Row([Text("Haptic Feedback Engine", 15, "#ffffff"), Spacer(), sw2], 10)

    // 4. SwiftUI Section 1: Settings
    let sec1_items: vector[Widget] = []
    sec1_items.push(switch_row1)
    sec1_items.push(Divider("#2c2c2e", 1))
    sec1_items.push(switch_row2)
    let sec1 = Section("Device Synchronization", sec1_items, "Requires Apple ID authentication")

    // 5. SwiftUI Gauge
    let gauge = Gauge(85, 0, 100, "Storage Optimization", "#34C759")

    // 6. Cupertino Action Sheet
    let act1 = CupertinoButton("Export as SwiftUI Package", "exportSwift()", true, "#007AFF")
    let act2 = CupertinoButton("Export as Flutter Widget Tree", "exportFlutter()", true, "#34C759")
    let actions: vector[Widget] = []
    actions.push(act1)
    actions.push(act2)
    let action_sheet = CupertinoActionSheet("Choose Multiplatform Target", "Cluster compiles directly to native host frameworks", actions, "Cancel", "cancelSheet()")

    // 7. Compose into SwiftUI Form
    let form_items: vector[Widget] = []
    form_items.push(nav_bar)
    form_items.push(Center(segment))
    form_items.push(sec1)
    form_items.push(gauge)
    form_items.push(action_sheet)

    let form = Form(form_items)
    return form

fn main() -> int:
    print("================================================================================")
    print("       ⚡ CLUSTER UI: APPLE CUPERTINO & SWIFTUI SHOWCASE                        ")
    print("================================================================================")

    let app: Widget = build_cupertino_swiftui_app()

    // 1. Render to Web HTML5 (Frosted glass blur & iOS design tokens)
    let html: string = render_page_html("Apple Cupertino - Cluster UI", app)
    print("✔ HTML5 Rendered: " + str(len(html)) + " bytes")

    // 2. Render to Native Apple SwiftUI View
    let swift: string = render_swiftui_view("CupertinoShowcaseView", app)
    print("✔ SwiftUI View Rendered: " + str(len(swift)) + " bytes")

    // 3. Render to Native Android Layout XML
    let xml: string = render_activity_layout_xml(app)
    print("✔ Android XML Rendered: " + str(len(xml)) + " bytes")

    if len(html) == 0 or len(xml) == 0 or len(swift) == 0:
        print("FAIL: One of the render outputs was empty.")
        sys_exit(1)

    print("--------------------------------------------------------------------------------")
    print("✔ All 3 platform targets verified successfully for Apple Cupertino & SwiftUI!")
    print("================================================================================")
    return 0
