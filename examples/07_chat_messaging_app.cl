// ==============================================================================
// Example 07: Modern Chat & Messaging App in Cluster UI
// Demonstrates: AppBar with Avatar & online status, Message bubbles,
//               Quick reply Chips (Wrap), Input row with Action button.
// Compiles to both Web HTML and Native Android Jetpack XML!
// ==============================================================================

import src/core/widget.cl
import src/render/html.cl
import src/render/android.cl

fn create_incoming_bubble(author: string, msg: string, time: string) -> Widget:
    let mut b_items: vector[Widget] = []
    b_items.push(Text(author, 12, "#58a6ff", true))
    b_items.push(Text(msg, 14, "#f0f6fc", false))
    b_items.push(Text(time, 10, "#8b949e", false))
    return Card(Column(b_items, 4), "#21262d", 12, 10)

fn create_outgoing_bubble(msg: string, time: string) -> Widget:
    let mut b_items: vector[Widget] = []
    b_items.push(Text(msg, 14, "#ffffff", false))
    b_items.push(Text(time + " · Read ✓✓", 10, "#d2a8ff", false))
    return Card(Column(b_items, 4), "#1f6feb", 12, 10)

fn build_chat_app() -> Widget:
    let mut app_children: vector[Widget] = []

    // 1. Top AppBar with Avatar and Contact info
    let av: Widget = Avatar("SC", "", 38, true, "#8957e5")
    let call_btn: Widget = Button("📞 Call", "startCall()", "#21262d", "#58a6ff", 12)
    let app_bar: Widget = AppBar("Sarah Connor", av, call_btn, "#161b22")
    app_children.push(app_bar)

    // 2. Chat Conversation Area
    let mut msgs: vector[Widget] = []
    
    // Date pill
    let mut date_row: vector[Widget] = []
    date_row.push(Spacer())
    date_row.push(Badge("Today, November 21", "#21262d", "#8b949e", 11))
    date_row.push(Spacer())
    msgs.push(Row(date_row))

    // Messages
    msgs.push(create_incoming_bubble("Sarah Connor", "Hey! Is the Cluster UI engine ready for production?", "10:41 AM"))
    msgs.push(create_outgoing_bubble("Yes! Pure Cluster, 0 dependencies, generates both HTML & Android XML.", "10:42 AM"))
    msgs.push(create_incoming_bubble("Sarah Connor", "Awesome! Can it run live hot-reload in the browser?", "10:43 AM"))
    msgs.push(create_outgoing_bubble("Sub-50ms execution speed, with live mobile preview on port 8080! 🚀", "10:44 AM"))

    // Quick replies (Wrap)
    let mut chips: vector[Widget] = []
    chips.push(Badge("👍 Looks great!", "#30363d", "#c9d1d9", 12))
    chips.push(Badge("🚀 Ship it now", "#30363d", "#c9d1d9", 12))
    chips.push(Badge("📱 Test on Android", "#30363d", "#c9d1d9", 12))
    msgs.push(Wrap(chips, 8))

    app_children.push(Box(Column(msgs, 12), 0, 0, 16, "#0d1117", 0))

    // 3. Message Input Bar
    let mut input_row: vector[Widget] = []
    input_row.push(Button("📎", "", "#21262d", "#8b949e", 14))
    input_row.push(Expanded(TextInput("Write a message to Sarah...", 14)))
    input_row.push(Button("Send ✈️", "sendMessage()", "#238636", "#ffffff", 13))
    
    app_children.push(Box(Row(input_row, 8), 0, 0, 12, "#161b22", 0))

    return Column(app_children, 0)

fn main() -> int:
    pln("==================================================")
    pln(" Cluster UI Showcase: Modern Chat App")
    pln(" Multi-Platform: HTML5 + Android Jetpack XML")
    pln("==================================================")

    let app: Widget = build_chat_app()

    // 1. Generate Web HTML
    let html: string = render_page_html("Chat with Sarah - Cluster UI", app)
    pln("\n[1] Generated HTML5 Length: " + str(len(html)) + " bytes")

    // 2. Generate Android Layout XML
    let xml: string = render_activity_layout_xml(app)
    pln("[2] Generated Android XML Length: " + str(len(xml)) + " bytes")

    pln("\n--- Sample Android XML (First 400 chars) ---")
    let mut preview: string = ""
    let mut i: int = 0
    let max_len: int = 400
    if len(xml) < 400:
        max_len = len(xml)
    while i < max_len:
        preview = preview + xml[i]
        i = i + 1
    pln(preview)
    pln("...\n")

    pln("✅ Chat App generated successfully!")
    return 0
