// ==============================================================================
// Cluster UI Example 12: Reactive State Counter & GPU Spring Animation
// Demonstrates Zero-Virtual-DOM fine-grained reactivity & Hardware Compositing
// Pure Native Cluster Language — Zero External Dependencies
// ==============================================================================

import src/core/widget.cl
import src/core/state.cl
import src/core/animation.cl
import src/render/html.cl

fn main() -> int:
    // 1. Declare reactive state
    let count_state = state_int("counter", 0)

    // 2. Hardware spring animation spec
    let spring = SpringAnimation(350)

    // 3. Header title & subtitle
    let title = Text("⚡ Fine-Grained Reactive Counter", 24, "#58a6ff", true)
    let subtitle = Text("Zero Virtual DOM · Hardware GPU Transitions · Host State Lowering", 13, "#8b949e")

    // 4. Large Counter Display (Bound to state_int("counter"))
    let counter_display = Text(bind(count_state), 64, "#e6edf3", true)

    // 5. Interactive Action Buttons with GPU Spring Animation
    let dec_btn = with_animation(
        Button("- Decrement", "Cluster.set('counter', Cluster.get('counter') - 1)", "#da3633", "#ffffff", 14),
        spring
    )
    let reset_btn = with_animation(
        Button("↺ Reset", "Cluster.set('counter', 0)", "#21262d", "#8b949e", 14),
        spring
    )
    let inc_btn = with_animation(
        Button("+ Increment", "Cluster.set('counter', Cluster.get('counter') + 1)", "#238636", "#ffffff", 14),
        spring
    )

    let actions_row = Row([dec_btn, reset_btn, inc_btn], 12)

    // 6. Metrics & Performance Card
    let stat1 = MetricCard("Frame Rate", "120 FPS", "Hardware Composited", true, "activity", "#3fb950")
    let stat2 = MetricCard("VDOM Diffs", "0 Diffs", "Direct Host Lowering", true, "cpu", "#58a6ff")
    let stat3 = MetricCard("Client Size", "0.3 KB", "Zero Runtime Bloat", true, "package", "#d29922")
    let stats_row = Row([stat1, stat2, stat3], 12)

    // 7. Compose into an Animated Card
    let card_content = Column([
        title,
        subtitle,
        Divider("#30363d", 1),
        Center(counter_display),
        Center(actions_row),
        Divider("#30363d", 1),
        stats_row
    ], 16, 24)

    let main_card = with_animation(
        Card(card_content, "#161b22", 16, 24),
        spring
    )

    // 8. Top-level layout
    let layout = Column([
        main_card
    ], 20, 20)

    // 9. Render & Output HTML5
    let html_page = render_page_html("Cluster UI - Reactive Counter & Animation", layout)
    pln(html_page)

    return 0
