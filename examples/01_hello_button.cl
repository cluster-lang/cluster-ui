// ==============================================================================
// Cluster UI — Example 01: Interactive Hello Button Card
// Demonstrates: Box, Column, Text, and Button components
// ==============================================================================

import src/core/widget.cl
import src/render/html.cl

fn main() -> int:
    // Build a declarative widget hierarchy (like Flutter Column / SwiftUI VStack):
    let mut card_children: vector[Widget] = []
    card_children.push(Text("⚡ Cluster Native UI", 22, "#58a6ff", true))
    card_children.push(Text("Zero JavaScript • Zero node_modules • Pure Cluster", 13, "#8b949e", false))
    card_children.push(Button("Get Started Now", "alert('Welcome to Cluster UI!')", "#238636", "#ffffff", 14))

    let card_content: Widget = Column(card_children, 14, 16)
    let root_card: Widget = Box(card_content, 380, 0, 12, "#161b22", 12)

    // Render directly to clean HTML5:
    let output_html: string = render_page_html("Cluster UI Demo", root_card)
    
    pln("=== Cluster UI Generated Output ===")
    pln(output_html)

    return 0
