// ==============================================================================
// Cluster UI: Theme & Design System Engine (src/core/theme.cl)
// Inspired by Material 3 (ColorScheme) and Apple Human Interface Guidelines
// Pure Cluster Language — Zero External Dependencies
// ==============================================================================

model Theme:
    name: string
    is_dark: bool

    // Core Brand & Functional Colors
    primary: string
    primary_hover: string
    secondary: string
    background: string
    surface: string
    surface_variant: string

    // Text & Content Colors
    text_primary: string
    text_secondary: string
    text_muted: string

    // Borders & Dividers
    border: string
    border_subtle: string

    // Status Colors
    success: string
    warning: string
    error: string
    info: string

    // Spacing & Radii (in dp / px)
    radius_sm: int
    radius_md: int
    radius_lg: int
    radius_full: int

    space_xs: int
    space_sm: int
    space_md: int
    space_lg: int
    space_xl: int

// Theme Presets

// Default GitHub / Jetpack Dark Theme
fn Theme_Dark() -> Theme:
    return Theme(
        name = "dark",
        is_dark = true,
        primary = "#238636",
        primary_hover = "#2ea043",
        secondary = "#1f6feb",
        background = "#0d1117",
        surface = "#161b22",
        surface_variant = "#21262d",
        text_primary = "#f0f6fc",
        text_secondary = "#c9d1d9",
        text_muted = "#8b949e",
        border = "#30363d",
        border_subtle = "#21262d",
        success = "#3fb950",
        warning = "#d29922",
        error = "#f85149",
        info = "#58a6ff",
        radius_sm = 6,
        radius_md = 10,
        radius_lg = 16,
        radius_full = 9999,
        space_xs = 4,
        space_sm = 8,
        space_md = 12,
        space_lg = 16,
        space_xl = 24
    )

// Modern Clean Light Theme
fn Theme_Light() -> Theme:
    return Theme(
        name = "light",
        is_dark = false,
        primary = "#0969da",
        primary_hover = "#0550ae",
        secondary = "#1a7f37",
        background = "#ffffff",
        surface = "#f6f8fa",
        surface_variant = "#eaeef2",
        text_primary = "#1f2328",
        text_secondary = "#424a53",
        text_muted = "#656d76",
        border = "#d0d7de",
        border_subtle = "#afb8c1",
        success = "#1a7f37",
        warning = "#9a6700",
        error = "#cf222e",
        info = "#0969da",
        radius_sm = 6,
        radius_md = 10,
        radius_lg = 16,
        radius_full = 9999,
        space_xs = 4,
        space_sm = 8,
        space_md = 12,
        space_lg = 16,
        space_xl = 24
    )

// Deep OLED Midnight Black Theme
fn Theme_Midnight() -> Theme:
    return Theme(
        name = "midnight",
        is_dark = true,
        primary = "#a371f7",
        primary_hover = "#8957e5",
        secondary = "#58a6ff",
        background = "#000000",
        surface = "#0d1117",
        surface_variant = "#161b22",
        text_primary = "#ffffff",
        text_secondary = "#e6edf3",
        text_muted = "#7d8590",
        border = "#21262d",
        border_subtle = "#161b22",
        success = "#3fb950",
        warning = "#e3b341",
        error = "#ff7b72",
        info = "#79c0ff",
        radius_sm = 8,
        radius_md = 12,
        radius_lg = 20,
        radius_full = 9999,
        space_xs = 4,
        space_sm = 8,
        space_md = 12,
        space_lg = 16,
        space_xl = 24
    )
