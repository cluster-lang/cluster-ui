// ==============================================================================
// Cluster UI Example 05: Multi-Platform Dual Export (Web + Native Android XML)
// Compiles the EXACT same Declarative Widget Tree to:
//   1. Modern Semantic HTML5 Web App
//   2. Native Android Layout XML (ConstraintLayout / LinearLayout / Material)
// ==============================================================================

import src/core/widget.cl
import src/render/html.cl
import src/render/android.cl

fn build_login_card() -> Widget:
    let mut card_content: vector[Widget] = []
    card_content.push(Text("Welcome Back", 22, "#ffffff", true))
    card_content.push(Text("Sign in to your Cluster Cloud workspace", 13, "#8b949e", false))
    card_content.push(Divider("#30363d", 1))

    card_content.push(Text("Email Address", 12, "#c9d1d9", true))
    card_content.push(TextInput("developer@cluster-lang.org", 14))

    card_content.push(Text("Password", 12, "#c9d1d9", true))
    card_content.push(TextInput("••••••••••••", 14))

    card_content.push(Toggle(true, "Remember this device for 30 days"))
    card_content.push(Button("Sign In to Cluster", "alert('Logging in...')", "#238636", "#ffffff", 14))

    return Card(Column(card_content, 12, 0), "#161b22", 14, 20)

fn main() -> int:
    let ui_tree: Widget = build_login_card()

    pln("======================================================================")
    pln("1. Web HTML5 Export (render_page_html):")
    pln("======================================================================")
    let web_html: string = render_page_html("Cluster Multi-Platform Login", ui_tree)
    pln(web_html)

    pln("\n======================================================================")
    pln("2. Native Android Layout XML Export (render_activity_layout_xml):")
    pln("======================================================================")
    let android_xml: string = render_activity_layout_xml(ui_tree)
    pln(android_xml)

    return 0
