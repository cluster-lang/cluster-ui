# Cluster UI (`cluster-ui`)

**Pure Native, Cross-Platform Declarative UI Framework for Cluster Language.**  
Inspired by the clean architecture of **Flutter** (`Widget`, `RenderObject`) and **SwiftUI** (`View`, `ViewModifier`).

> 🚀 **100% Zero Dependencies:** Zero JavaScript, zero node_modules, zero external web frameworks. Compiles to native binary code in **~35ms** with LLVM.

---

## 🏗️ Architecture

```
cluster-ui/
├── src/
│   ├── core/
│   │   ├── geometry.cl       # EdgeInsets, Size, Point
│   │   ├── color.cl          # Color palette & Hex/RGBA parsers
│   │   └── widget.cl         # Multi-platform Declarative Widget Tree
│   └── render/
│       ├── html.cl           # Semantic HTML5 & Modern Flex/Grid Renderer
│       └── android.cl        # Native Android Layout XML (Jetpack/Material) Renderer
├── examples/
│   ├── 01_hello_button.cl    # Quick start button
│   ├── 02_profile_card.cl    # Social profile card with layout stacks
│   ├── 03_dashboard.cl       # Analytics dashboard (Cards, Badges, ProgressBars)
│   ├── 04_settings_view.cl   # System preferences (AppBar, ListTiles, Toggles)
│   └── 05_android_export.cl  # Dual export: Web HTML5 + Native Android XML
```

---

## 🧩 Supported Components

| Component | Flutter Equivalent | SwiftUI Equivalent | Android Target |
|---|---|---|---|
| `Text` | `Text` | `Text` | `TextView` |
| `Button` | `ElevatedButton` | `Button` | `Button` |
| `Column` / `VStack` | `Column` | `VStack` | `LinearLayout (vertical)` |
| `Row` / `HStack` | `Row` | `HStack` | `LinearLayout (horizontal)` |
| `ZStack` / `Stack` | `Stack` | `ZStack` | `FrameLayout` |
| `Box` / `Container` | `Container` | `frame()` | `FrameLayout` |
| `Card` | `Card` | `GroupBox` | `CardView` |
| `TextInput` | `TextField` | `TextField` | `EditText` |
| `Image` | `Image.network` | `Image` | `ImageView` |
| `Badge` / `Chip` | `Chip` | `Badge` | `TextView / Chip` |
| `Toggle` / `Switch` | `Switch` | `Toggle` | `SwitchCompat` |
| `ProgressBar` | `LinearProgressIndicator` | `ProgressView` | `ProgressBar` |
| `ListTile` | `ListTile` | `NavigationLink label` | `LinearLayout (item)` |
| `AppBar` | `AppBar` | `NavigationTitle` | `Toolbar / AppBarLayout` |
| `Divider` | `Divider` | `Divider` | `View (separator)` |
| `Spacer` | `Spacer` | `Spacer` | `Space (weight=1)` |
| `Center` | `Center` | `center frame` | `Gravity center` |
| `Link` | `InkWell` | `Link` | `TextView (link)` |

---

## 🏃 Running Examples

Compile and execute natively in milliseconds:

```bash
# Dashboard
cl run examples/03_dashboard.cl

# Settings View
cl run examples/04_settings_view.cl

# Dual Web + Android Export
cl run examples/05_android_export.cl
```
