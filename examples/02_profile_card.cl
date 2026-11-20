// ==============================================================================
// Cluster UI — Example 02: Modern Social Profile Card
// Demonstrates: Nested Columns (VStack), Rows (HStack), Badges, Buttons, and Inputs
// ==============================================================================

import src/core/widget.cl
import src/render/html.cl

fn main() -> int:
    // Header Row: Avatar Initials + User Details (SwiftUI HStack / Flutter Row)
    let mut avatar_content: vector[Widget] = []
    avatar_content.push(Text("ZK", 18, "#ffffff", true))
    let avatar_box: Widget = Box(Column(avatar_content, 0, 10), 48, 48, 0, "#1f6feb", 24)

    let mut user_details: vector[Widget] = []
    user_details.push(Text("Zaid Khan", 18, "#e6edf3", true))
    user_details.push(Text("@zaid_zk • Core Architect", 12, "#8b949e", false))
    let user_col: Widget = Column(user_details, 4, 0)

    let mut header_items: vector[Widget] = []
    header_items.push(avatar_box)
    header_items.push(user_col)
    let header_row: Widget = Row(header_items, 12, 0)

    // Bio text
    let bio_text: Widget = Text("Building Cluster Language — the zero-dependency, ultra-fast language for AI, Systems & Native UI.", 13, "#c9d1d9", false)

    // Stats Row
    let mut stats_items: vector[Widget] = []
    stats_items.push(Text("⭐ 1.2k Stars", 12, "#3fb950", true))
    stats_items.push(Text("👥 420 Contributors", 12, "#58a6ff", true))
    stats_items.push(Text("🚀 v1.0 Native", 12, "#d29922", true))
    let stats_row: Widget = Row(stats_items, 16, 0)

    // Action Buttons
    let mut actions: vector[Widget] = []
    actions.push(Button("Follow", "alert('Followed Zaid!')", "#238636", "#ffffff", 13))
    actions.push(Button("Message", "alert('Opening chat...')", "#21262d", "#58a6ff", 13))
    let actions_row: Widget = Row(actions, 10, 0)

    // Assemble Main Card (SwiftUI VStack / Flutter Column)
    let mut card_body: vector[Widget] = []
    card_body.push(header_row)
    card_body.push(bio_text)
    card_body.push(stats_row)
    card_body.push(actions_row)

    let card_content: Widget = Column(card_body, 16, 20)
    let profile_card: Widget = Box(card_content, 420, 0, 0, "#161b22", 16)

    let html_page: string = render_page_html("Cluster UI Profile Card", profile_card)
    
    pln("=== Profile Card Rendered Successfully ===")
    pln(html_page)

    return 0
