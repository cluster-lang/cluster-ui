// ==============================================================================
// Cluster UI: Color System
// Equivalent to Flutter: Color, Colors
// Equivalent to SwiftUI: Color
// ==============================================================================

model Color:
    hex: string
    r: int
    g: int
    b: int
    a: float

    fn to_css(&self) -> string:
        if len(self.hex) > 0:
            return self.hex
        return "rgba(" + str(self.r) + "," + str(self.g) + "," + str(self.b) + "," + str(self.a) + ")"

fn color_hex(hex_code: string) -> Color:
    return Color(hex = hex_code, r = 0, g = 0, b = 0, a = 1.0)

fn color_rgb(r: int, g: int, b: int) -> Color:
    return Color(hex = "", r = r, g = g, b = b, a = 1.0)

fn color_rgba(r: int, g: int, b: int, a: float) -> Color:
    return Color(hex = "", r = r, g = g, b = b, a = a)

// Standard Cluster Palette
fn Color_white() -> string: return "#FFFFFF"
fn Color_black() -> string: return "#000000"
fn Color_transparent() -> string: return "transparent"
fn Color_primary() -> string: return "#58a6ff"
fn Color_success() -> string: return "#3fb950"
fn Color_danger() -> string: return "#f85149"
fn Color_warning() -> string: return "#d29922"
fn Color_bg_dark() -> string: return "#0d1117"
fn Color_bg_card() -> string: return "#161b22"
