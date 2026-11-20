// ==============================================================================
// Cluster UI: Core Geometry & Insets
// Equivalent to Flutter: EdgeInsets, Size, Offset
// Equivalent to SwiftUI: EdgeInsets, CGSize, CGPoint
// ==============================================================================

model EdgeInsets:
    top: int
    right: int
    bottom: int
    left: int

    fn is_zero(&self) -> bool:
        return self.top == 0 and self.right == 0 and self.bottom == 0 and self.left == 0

fn insets_all(val: int) -> EdgeInsets:
    return EdgeInsets(top = val, right = val, bottom = val, left = val)

fn insets_symmetric(vertical: int, horizontal: int) -> EdgeInsets:
    return EdgeInsets(top = vertical, right = horizontal, bottom = vertical, left = horizontal)

fn insets_ltrb(left: int, top: int, right: int, bottom: int) -> EdgeInsets:
    return EdgeInsets(top = top, right = right, bottom = bottom, left = left)

model Size:
    width: int
    height: int

model Point:
    x: int
    y: int
