// ==============================================================================
// Cluster UI: Interactive Controls & Form Widgets
// TextInput, Slider, Checkbox, Radio, Toggle/Switch, Stepper, SegmentedButton, Dropdown
// ==============================================================================

import src/core/model.cl

// TextInput (Flutter TextField / SwiftUI TextField)
fn TextInput(placeholder: string = "Type here...", font_size: int = 14) -> Widget:
    let mut w: Widget = new_widget(7)
    w.placeholder = placeholder
    w.font_size = font_size
    w.color = "#e6edf3"
    w.bg_color = "#161b22"
    w.padding = 10
    w.border_radius = 6
    w.border_color = "#30363d"
    w.border_width = 1
    return w

// Toggle / Switch (Flutter Switch / SwiftUI Toggle)
fn Toggle(is_on: bool = false, label: string = "", on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(13)
    w.is_checked = is_on
    w.text = label
    w.on_click = on_click
    w.bg_color = "#238636"
    return w

fn Switch(is_on: bool = false, label: string = "", on_click: string = "") -> Widget:
    return Toggle(is_on, label, on_click)

// Slider (Flutter Slider / SwiftUI Slider)
fn Slider(value: int = 50, min_value: int = 0, max_value: int = 100, on_change: string = "") -> Widget:
    let mut w: Widget = new_widget(31)
    w.value = value
    w.min_value = min_value
    w.max_value = max_value
    w.on_change = on_change
    w.color = "#238636"
    return w

// Checkbox (Flutter Checkbox / SwiftUI Toggle checkbox style)
fn Checkbox(is_checked: bool = false, label: string = "", on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(32)
    w.is_checked = is_checked
    w.text = label
    w.on_click = on_click
    w.color = "#238636"
    return w

// Radio (Flutter Radio / SwiftUI Picker radio style)
fn Radio(is_selected: bool = false, label: string = "", value_str: string = "", on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(33)
    w.is_checked = is_selected
    w.text = label
    w.value_str = value_str
    w.on_click = on_click
    w.color = "#238636"
    return w

// Stepper (Flutter Stepper / SwiftUI Stepper)
fn Stepper(label: string = "", value: int = 1, min_value: int = 0, max_value: int = 100, on_change: string = "") -> Widget:
    let mut w: Widget = new_widget(41)
    w.text = label
    w.value = value
    w.min_value = min_value
    w.max_value = max_value
    w.on_change = on_change
    w.color = "#58a6ff"
    w.bg_color = "#161b22"
    return w

// SegmentedButton (Flutter SegmentedButton / SwiftUI Picker.segmented)
fn SegmentedButton(options: vector[string], active_index: int = 0, on_click: string = "") -> Widget:
    let mut w: Widget = new_widget(42)
    w.options = options
    w.active_index = active_index
    w.on_click = on_click
    w.color = "#58a6ff"
    w.bg_color = "#21262d"
    return w

// Dropdown (Flutter DropdownButton / SwiftUI Picker)
fn Dropdown(options: vector[string], selected_value: string = "") -> Widget:
    let mut w: Widget = new_widget(28)
    w.options = options
    w.value_str = selected_value
    w.bg_color = "#161b22"
    w.color = "#e6edf3"
    w.border_color = "#30363d"
    w.border_radius = 6
    w.padding = 8
    return w
