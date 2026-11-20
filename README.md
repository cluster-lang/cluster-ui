# Cluster UI (cluster-ui)

**100% Pure, Zero-Dependency, Native Declarative UI Component System for Cluster Language.**

Inspired by the battle-tested component architectures of **Flutter (Dart)** and **SwiftUI (Apple Swift)**, translated into pure Cluster models with zero JavaScript, zero npm packages, zero Gradle bloat, and instantaneous native LLVM compilation.

---

## 🏛 Architecture & References

This repository contains local reference clones of the world's leading declarative UI engines (kept in `.gitignore`):
- **`flutter/`**: Google's Flutter framework (`packages/flutter/lib/src/widgets/`)
- **`swift/`**: Open-source implementation of Apple's SwiftUI (`Sources/OpenSwiftUI/`)

### Porting Mapping Matrix

| Cluster UI Component | Flutter Source Reference | SwiftUI Source Reference | Purpose |
| :--- | :--- | :--- | :--- |
| **`Text`** | `text.dart` | `Sources/OpenSwiftUI/View/Text.swift` | Typography, labels & paragraphs |
| **`Box` / `Container`** | `container.dart` | `Sources/OpenSwiftUI/Layout/View+Frame.swift` | Padding, margin, background, border |
| **`Column`** | `basic.dart` (`Column`) | `Sources/OpenSwiftUI/Layout/VStack.swift` | Top-to-bottom vertical stacking |
| **`Row`** | `basic.dart` (`Row`) | `Sources/OpenSwiftUI/Layout/HStack.swift` | Left-to-right horizontal flow |
| **`Button`** | `material/elevated_button.dart` | `Sources/OpenSwiftUI/View/Button.swift` | Interactive button with click callbacks |
| **`Spacer`** | `basic.dart` (`Spacer`) | `Sources/OpenSwiftUI/Layout/Spacer.swift` | Flexible expanding spacing |
| **`Stack`** | `basic.dart` (`Stack`) | `Sources/OpenSwiftUI/Layout/ZStack.swift` | Layered 2D overlay positioning |
| **`TextInput`** | `text_selection.dart` | `Sources/OpenSwiftUI/View/TextField.swift` | Text input from keyboard |

---

## 🎯 Dual-Target Zero-Junk Rendering

A single Cluster UI tree can compile to:
1. **Web Target**: Generates lean, semantic HTML5 / Modern CSS Flexbox (zero npm runtime).
2. **Android Native Target**: Direct Skia / Android Canvas drawing commands at 120 FPS (zero JavaScript VM).
