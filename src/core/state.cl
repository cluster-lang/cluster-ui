// ==============================================================================
// Cluster UI: Reactive State Model & Direct Binding
// Zero Virtual DOM, Zero Garbage Collection Pauses, Direct Host Lowering
// Pure Cluster Language — 100% Zero Dependencies
// ==============================================================================

import src/core/model.cl

model State:
    id: string
    int_val: int
    str_val: string
    bool_val: bool

fn state_int(name: string, val: int = 0) -> State:
    return State(id = name, int_val = val, str_val = "", bool_val = false)

fn state_str(name: string, val: string = "") -> State:
    return State(id = name, int_val = 0, str_val = val, bool_val = false)

fn state_bool(name: string, val: bool = false) -> State:
    return State(id = name, int_val = 0, str_val = "", bool_val = val)

fn bind(s: State) -> string:
    return "{{state:" + s.id + "}}"

fn with_bind(w: Widget, s: State) -> Widget:
    let mut modified: Widget = w
    modified.bind_key = s.id
    return modified
