// ==============================================================================
// Example 06: E-Commerce Storefront in Cluster UI
// Demonstrates: AppBar, TextInput (Search), Wrap (Categories), Grid (Products),
//               Cards, Badges, Buttons, and BottomNavigationBar
// Compiles to both Web HTML and Native Android Jetpack XML!
// ==============================================================================

import src/core/widget.cl
import src/render/html.cl
import src/render/android.cl

fn create_product_card(name: string, brand: string, price: string, tag: string) -> Widget:
    let mut items: vector[Widget] = []
    
    // Top tag
    let mut header_row: vector[Widget] = []
    header_row.push(Badge(tag, "#1f6feb", "#ffffff", 10))
    header_row.push(Spacer())
    header_row.push(Badge(price, "#238636", "#ffffff", 11))
    items.push(Row(header_row))
    
    // Title & details
    items.push(Text(name, 16, "#f0f6fc", true))
    items.push(Text(brand, 12, "#8b949e", false))
    items.push(Divider("#30363d", 1))
    
    // Action button
    items.push(Button("Add to Cart 🛒", "addToCart()", "#238636", "#ffffff", 12))
    
    return Card(Column(items, 8), "#161b22", 12, 14)

fn build_store_app() -> Widget:
    let mut app_children: vector[Widget] = []

    // 1. App Bar
    let back_btn: Widget = Button("←", "", "#21262d", "#e6edf3", 14)
    let cart_badge: Widget = Badge("3 items", "#8957e5", "#ffffff", 11)
    let app_bar: Widget = AppBar("⚡ KickStore Pro", back_btn, cart_badge, "#161b22")
    app_children.push(app_bar)

    // 2. Body Container
    let mut body_items: vector[Widget] = []
    
    // Search Bar
    body_items.push(TextInput("🔍 Search shoes, streetwear, drops...", 14))

    // Categories (Wrap)
    let mut cats: vector[Widget] = []
    cats.push(Badge("🔥 Featured", "#238636", "#ffffff", 12))
    cats.push(Badge("👟 Running", "#21262d", "#8b949e", 12))
    cats.push(Badge("🏀 Basketball", "#21262d", "#8b949e", 12))
    cats.push(Badge("⚡ Lifestyle", "#21262d", "#8b949e", 12))
    cats.push(Badge("🏷️ Sale -40%", "#da3633", "#ffffff", 12))
    body_items.push(Wrap(cats, 8))

    // Section Header
    let mut sec_row: vector[Widget] = []
    sec_row.push(Text("Trending Kicks", 18, "#f0f6fc", true))
    sec_row.push(Spacer())
    sec_row.push(Link("See all 128 items →", "#", "#58a6ff", 12))
    body_items.push(Row(sec_row))

    // Product Grid (2 columns)
    let mut products: vector[Widget] = []
    products.push(create_product_card("Air Zoom 90", "Nike Running Edition", "$149.00", "NEW DROP"))
    products.push(create_product_card("UltraBoost Pro", "Adidas Performance", "$189.00", "POPULAR"))
    products.push(create_product_card("Jordan Retro High", "Air Jordan Classic", "$210.00", "LIMITED"))
    products.push(create_product_card("CloudFlow X", "On Running Swiss", "$135.00", "RESTOCKED"))
    body_items.push(Grid(products, 2, 12))

    app_children.push(Box(Column(body_items, 16), 0, 0, 16, "#0d1117", 0))

    // 3. Bottom Navigation Bar
    let mut nav_tabs: vector[Widget] = []
    nav_tabs.push(TabItem("Home", "🏠", true, 0))
    nav_tabs.push(TabItem("Explore", "🔍", false, 0))
    nav_tabs.push(TabItem("Cart", "🛒", false, 3))
    nav_tabs.push(TabItem("Profile", "👤", false, 0))
    app_children.push(BottomNavigationBar(nav_tabs, "#161b22"))

    return Column(app_children, 0)

fn main() -> int:
    pln("==================================================")
    pln(" Cluster UI Showcase: E-Commerce Storefront")
    pln(" Multi-Platform: HTML5 + Android Jetpack XML")
    pln("==================================================")

    let app: Widget = build_store_app()

    // 1. Generate Web HTML
    let html: string = render_page_html("KickStore Pro - Cluster UI", app)
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

    pln("✅ E-Commerce App generated successfully!")
    return 0
