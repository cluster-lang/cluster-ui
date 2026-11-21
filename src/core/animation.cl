// ==============================================================================
// Cluster UI: Declarative Animations & GPU Hardware Compositing
// Pure Native Cluster — Zero CPU Frame Budget Exhaustion
// 100% Zero Dependencies
// ==============================================================================

import src/core/model.cl

model AnimationSpec:
    curve: string
    duration_ms: int
    delay_ms: int
    property: string

fn SpringAnimation(duration_ms: int = 350) -> AnimationSpec:
    return AnimationSpec(
        curve = "cubic-bezier(0.34, 1.56, 0.64, 1)",
        duration_ms = duration_ms,
        delay_ms = 0,
        property = "all"
    )

fn EaseInOut(duration_ms: int = 250) -> AnimationSpec:
    return AnimationSpec(
        curve = "cubic-bezier(0.4, 0, 0.2, 1)",
        duration_ms = duration_ms,
        delay_ms = 0,
        property = "all"
    )

fn LinearAnimation(duration_ms: int = 200) -> AnimationSpec:
    return AnimationSpec(
        curve = "linear",
        duration_ms = duration_ms,
        delay_ms = 0,
        property = "all"
    )

fn with_animation(w: Widget, anim: AnimationSpec) -> Widget:
    let mut modified: Widget = w
    modified.is_animated = true
    modified.anim_curve = anim.curve
    modified.anim_duration = anim.duration_ms
    return modified
