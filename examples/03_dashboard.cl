// ==============================================================================
// Cluster UI Example 03: Modern Analytics Dashboard
// Demonstrates: Card, Badge, ProgressBar, ListTile, VStack, HStack, Button, Divider
// ==============================================================================

import src/core/widget.cl
import src/render/html.cl

fn main() -> int:
    // Stat Card 1: Active Users
    let mut stat1_items: vector[Widget] = []
    let mut s1_header: vector[Widget] = []
    s1_header.push(Text("Active Nodes", 13, "#8b949e", false))
    s1_header.push(Spacer())
    s1_header.push(Badge("+18.4%", "#238636", "#ffffff", 11))
    stat1_items.push(Row(s1_header, 8, 0))
    stat1_items.push(Text("14,892", 28, "#ffffff", true))
    stat1_items.push(ProgressBar(74, "#238636", "#21262d", 6))
    let card1: Widget = Card(Column(stat1_items, 10, 0), "#161b22", 12, 16)

    // Stat Card 2: Compiler Throughput
    let mut stat2_items: vector[Widget] = []
    let mut s2_header: vector[Widget] = []
    s2_header.push(Text("Throughput", 13, "#8b949e", false))
    s2_header.push(Spacer())
    s2_header.push(Badge("Ultra Fast", "#1f6feb", "#ffffff", 11))
    stat2_items.push(Row(s2_header, 8, 0))
    stat2_items.push(Text("820k ops/s", 28, "#58a6ff", true))
    stat2_items.push(ProgressBar(92, "#1f6feb", "#21262d", 6))
    let card2: Widget = Card(Column(stat2_items, 10, 0), "#161b22", 12, 16)

    // Stat Row
    let mut stats_row: vector[Widget] = []
    stats_row.push(card1)
    stats_row.push(card2)

    // Recent Deployments List
    let mut list_items: vector[Widget] = []
    list_items.push(Text("Live Cluster Deployments", 16, "#e6edf3", true))
    list_items.push(Divider("#30363d", 1))
    list_items.push(ListTile("cluster-core-v1.0", "Deployed 2m ago • Frankfurt (eu-central)", "🚀", "alert('Viewing cluster-core')"))
    list_items.push(ListTile("zk-nn-training-node", "Healthy • 8x Tensor Workers Active", "⚡", "alert('Viewing zk-nn')"))
    list_items.push(ListTile("mobile-apk-pipeline", "Built in 34ms • Zero Dependencies", "📱", "alert('Viewing apk-pipeline')"))
    let list_card: Widget = Card(Column(list_items, 8, 0), "#161b22", 12, 16)

    // Dashboard Container
    let mut page_items: vector[Widget] = []
    page_items.push(Text("Cluster Cloud Dashboard", 24, "#ffffff", true))
    page_items.push(Text("Real-time telemetry and cluster language compiler metrics", 14, "#8b949e", false))
    page_items.push(Row(stats_row, 16, 0))
    page_items.push(list_card)

    let root: Widget = Box(Column(page_items, 16, 0), 680, 0, 0, "", 0)
    let html_out: string = render_page_html("Cluster UI Dashboard", root)

    pln("=== Cluster UI Dashboard Rendered ===")
    pln(html_out)
    return 0
