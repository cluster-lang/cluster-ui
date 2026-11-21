# Cluster UI (`cluster-ui`)

**Pure Native, Cross-Platform Declarative UI Framework for Cluster Language.**  
Inspired by the clean architecture of **Flutter** (`Widget`, `RenderObject`) and **SwiftUI** (`View`, `ViewModifier`).

> 🚀 **100% Zero Dependencies:** Zero JavaScript, zero node_modules, zero external web runtimes. Compiles directly into native machine code with LLVM in milliseconds.
> 📱 **1 Codebase -> 3 Platforms:** Write once in Cluster, compile to **Web HTML5/CSS**, **Android Jetpack XML**, and **Apple SwiftUI**!

---

## 🏗️ Architecture

```
cluster-ui/
├── src/
│   ├── ui.cl                 # Unified Framework Entry Point
│   ├── core/
│   │   ├── theme.cl          # Dark, Light, and Midnight Design Tokens
│   │   └── widget.cl         # 30 Multi-platform Declarative Widgets
│   └── render/
│       ├── html.cl           # Semantic HTML5 & Modern Flex/Grid CSS Renderer
│       ├── android.cl        # Native Android Layout XML (Jetpack/Material) Renderer
│       └── swiftui.cl        # Native Apple SwiftUI Code Generator
├── examples/
│   ├── 01_hello_button.cl    # Quick start button & basic widgets
│   ├── 02_profile_card.cl    # Social profile card with layout stacks
│   ├── 03_dashboard.cl       # Analytics dashboard (Cards, Badges, ProgressBars)
│   ├── 04_settings_view.cl   # System preferences (AppBar, ListTiles, Toggles)
│   ├── 05_android_export.cl  # Dual export: Web HTML5 + Android XML
│   ├── 06_ecommerce_app.cl   # Storefront: Search, Categories Wrap, Product Grid, BottomNav
│   ├── 07_chat_messaging_app.cl # Chat: Avatars, Bubbles, Quick replies, Input row
│   └── 08_multiplatform_export.cl # Universal 3-target export (Web + Android + iOS)
```

---

## 🧩 Supported Components (30 Widgets)

| # | Component | Flutter Equivalent | SwiftUI Equivalent | Android Jetpack Target |
|---|---|---|---|---|
| 1 | `Text` | `Text` | `Text` | `TextView` |
| 2 | `Button` | `ElevatedButton` | `Button` | `MaterialButton` |
| 3 | `Column` / `VStack` | `Column` | `VStack` | `LinearLayout (vertical)` |
| 4 | `Row` / `HStack` | `Row` | `HStack` | `LinearLayout (horizontal)` |
| 5 | `Box` / `Container` | `Container` | `frame()` | `FrameLayout` |
| 6 | `Spacer` | `Spacer` | `Spacer` | `Space (layout_weight=1)` |
| 7 | `TextInput` | `TextField` | `TextField` | `EditText` |
| 8 | `Image` | `Image.network` | `AsyncImage` | `ImageView` |
| 9 | `ZStack` / `Stack` | `Stack` | `ZStack` | `FrameLayout` |
| 10 | `Divider` | `Divider` | `Divider` | `View (separator line)` |
| 11 | `Card` | `Card` | `GroupBox` | `androidx.cardview.widget.CardView` |
| 12 | `Badge` / `Chip` | `Chip` | `Badge` | `com.google.android.material.chip.Chip` |
| 13 | `Toggle` / `Switch` | `Switch` | `Toggle` | `androidx.appcompat.widget.SwitchCompat` |
| 14 | `ProgressBar` | `LinearProgressIndicator` | `ProgressView` | `ProgressBar (horizontal)` |
| 15 | `ListTile` | `ListTile` | `NavigationLink label` | `LinearLayout (icon + title + subtitle)` |
| 16 | `Center` | `Center` | `center frame` | `FrameLayout (gravity=center)` |
| 17 | `Link` | `InkWell` | `Link` | `TextView (autoLink)` |
| 18 | `Expanded` | `Expanded` | `frame(maxWidth: .infinity)` | `FrameLayout (layout_weight=1)` |
| 19 | `AppBar` | `AppBar` | `NavigationTitle / Toolbar` | `com.google.android.material.appbar.MaterialToolbar` |
| 20 | `BottomNavigationBar` | `BottomNavigationBar` | `TabView` | `com.google.android.material.bottomnavigation.BottomNavigationView` |
| 21 | `TabItem` | `BottomNavigationBarItem` | `tabItem` | `com.google.android.material.tabs.TabItem` |
| 22 | `FloatingActionButton` | `FloatingActionButton` | `floating button overlay` | `com.google.android.material.floatingactionbutton.FloatingActionButton` |
| 23 | `Dialog` | `AlertDialog` | `.alert` | `CardView dialog container` |
| 24 | `SnackBar` | `SnackBar` | `banner / toast` | `Snackbar layout` |
| 25 | `Grid` | `GridView` | `LazyVGrid` | `GridLayout` |
| 26 | `Wrap` | `Wrap` | `FlowLayout` | `com.google.android.flexbox.FlexboxLayout` |
| 27 | `Avatar` | `CircleAvatar` | `clipShape(Circle())` | `Circular CardView / ImageView` |
| 28 | `Dropdown` | `DropdownButton` | `Picker` | `Spinner` |
| 29 | `Scaffold` | `Scaffold` | `WindowGroup View` | `androidx.coordinatorlayout.widget.CoordinatorLayout` |
| 30 | `ScrollView` | `SingleChildScrollView` | `ScrollView` | `androidx.core.widget.NestedScrollView` |

---

## 🚀 Quick Example

```cluster
import src/ui.cl

fn main() -> int:
    let profile_card: Widget = Card(
        Column([
            Avatar("AK", "", 50, true),
            Text("Alamgir Khan", 18, "#ffffff", true),
            Text("Cluster Language Architect", 12, "#8b949e"),
            Button("Follow", "followUser()", "#238636")
        ], 10),
        "#161b22", 12, 16
    )

    // 1. Web HTML
    let html: string = render_page_html("Profile", profile_card)

    // 2. Android XML
    let xml: string = render_activity_layout_xml(profile_card)

    // 3. Apple SwiftUI
    let swift: string = render_swiftui_view("ProfileView", profile_card)

    pln("Web Length: " + str(len(html)))
    pln("Android Length: " + str(len(xml)))
    pln("SwiftUI Length: " + str(len(swift)))
    return 0
```

---

## 🏃 Running Examples

Compile and execute natively in milliseconds:

```bash
# E-Commerce App (HTML + Android XML)
cl run examples/06_ecommerce_app.cl

# Modern Chat App (HTML + Android XML)
cl run examples/07_chat_messaging_app.cl

# Universal 3-Platform Export (HTML + Android XML + iOS SwiftUI)
cl run examples/08_multiplatform_export.cl
```
