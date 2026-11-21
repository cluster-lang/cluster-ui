// ==============================================================================
// Cluster UI: Native Android Layout XML Renderer
// Translates Cluster UI Declarative Widget Tree directly into Native Android XML
// Targets Android Jetpack / Material Components with Zero Third-Party Node Jargon
// ==============================================================================

import src/core/widget.cl

fn indent(level: int) -> string:
    let mut s: string = ""
    let mut i: int = 0
    while i < level:
        s = s + "    "
        i = i + 1
    return s

fn render_widget_to_android_xml(w: Widget, depth: int = 1) -> string:
    let k: int = w.kind
    let ind: string = indent(depth)

    // 1: Text -> TextView
    if k == 1:
        let mut xml: string = ind + "<TextView\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:text=\"" + w.text + "\"\n"
        xml = xml + ind + "    android:textSize=\"" + str(w.font_size) + "sp\"\n"
        xml = xml + ind + "    android:textColor=\"" + w.color + "\"\n"
        if w.bold:
            xml = xml + ind + "    android:textStyle=\"bold\"\n"
        xml = xml + ind + "/>"
        return xml

    // 2: Button -> Button / MaterialButton
    if k == 2:
        let mut xml: string = ind + "<Button\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:text=\"" + w.text + "\"\n"
        xml = xml + ind + "    android:textSize=\"" + str(w.font_size) + "sp\"\n"
        xml = xml + ind + "    android:backgroundTint=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    android:textColor=\"" + w.color + "\"\n"
        xml = xml + ind + "/>"
        return xml

    // 3: Column / VStack -> LinearLayout (Vertical)
    if k == 3:
        let mut xml: string = ind + "<LinearLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:orientation=\"vertical\"\n"
        if w.padding > 0:
            xml = xml + ind + "    android:padding=\"" + str(w.padding) + "dp\"\n"
        xml = xml + ind + ">\n"
        let mut i: int = 0
        while i < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[i], depth + 1) + "\n"
            i = i + 1
        xml = xml + ind + "</LinearLayout>"
        return xml

    // 4: Row / HStack -> LinearLayout (Horizontal)
    if k == 4:
        let mut xml: string = ind + "<LinearLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:orientation=\"horizontal\"\n"
        xml = xml + ind + "    android:gravity=\"center_vertical\"\n"
        if w.padding > 0:
            xml = xml + ind + "    android:padding=\"" + str(w.padding) + "dp\"\n"
        xml = xml + ind + ">\n"
        let mut j: int = 0
        while j < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[j], depth + 1) + "\n"
            j = j + 1
        xml = xml + ind + "</LinearLayout>"
        return xml

    // 5: Box / Container -> FrameLayout / LinearLayout
    if k == 5:
        let mut w_str: string = "wrap_content"
        let mut h_str: string = "wrap_content"
        if w.width > 0:
            w_str = str(w.width) + "dp"
        if w.height > 0:
            h_str = str(w.height) + "dp"
        let mut xml: string = ind + "<FrameLayout\n"
        xml = xml + ind + "    android:layout_width=\"" + w_str + "\"\n"
        xml = xml + ind + "    android:layout_height=\"" + h_str + "\"\n"
        if len(w.bg_color) > 0:
            xml = xml + ind + "    android:background=\"" + w.bg_color + "\"\n"
        if w.padding > 0:
            xml = xml + ind + "    android:padding=\"" + str(w.padding) + "dp\"\n"
        xml = xml + ind + ">\n"
        let mut bi: int = 0
        while bi < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[bi], depth + 1) + "\n"
            bi = bi + 1
        xml = xml + ind + "</FrameLayout>"
        return xml

    // 6: Spacer -> Space with weight
    if k == 6:
        let mut xml: string = ind + "<Space\n"
        xml = xml + ind + "    android:layout_width=\"0dp\"\n"
        xml = xml + ind + "    android:layout_height=\"0dp\"\n"
        xml = xml + ind + "    android:layout_weight=\"1\"\n"
        xml = xml + ind + "/>"
        return xml

    // 7: TextInput -> EditText
    if k == 7:
        let mut xml: string = ind + "<EditText\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:hint=\"" + w.placeholder + "\"\n"
        xml = xml + ind + "    android:textColor=\"" + w.color + "\"\n"
        xml = xml + ind + "    android:textSize=\"" + str(w.font_size) + "sp\"\n"
        xml = xml + ind + "/>"
        return xml

    // 8: Image -> ImageView
    if k == 8:
        let mut w_str: string = "wrap_content"
        let mut h_str: string = "wrap_content"
        if w.width > 0:
            w_str = str(w.width) + "dp"
        if w.height > 0:
            h_str = str(w.height) + "dp"
        let mut xml: string = ind + "<ImageView\n"
        xml = xml + ind + "    android:layout_width=\"" + w_str + "\"\n"
        xml = xml + ind + "    android:layout_height=\"" + h_str + "\"\n"
        xml = xml + ind + "    android:contentDescription=\"" + w.text + "\"\n"
        xml = xml + ind + "    android:scaleType=\"centerCrop\"\n"
        xml = xml + ind + "/>"
        return xml

    // 9: ZStack / Stack -> FrameLayout
    if k == 9:
        let mut xml: string = ind + "<FrameLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + ">\n"
        let mut si: int = 0
        while si < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[si], depth + 1) + "\n"
            si = si + 1
        xml = xml + ind + "</FrameLayout>"
        return xml

    // 10: Divider -> View (Separator line)
    if k == 10:
        let mut xml: string = ind + "<View\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"" + str(w.height) + "dp\"\n"
        xml = xml + ind + "    android:background=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "/>"
        return xml

    // 11: Card -> CardView
    if k == 11:
        let mut xml: string = ind + "<androidx.cardview.widget.CardView\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    app:cardCornerRadius=\"" + str(w.border_radius) + "dp\"\n"
        xml = xml + ind + "    app:cardBackgroundColor=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    app:cardElevation=\"4dp\"\n"
        xml = xml + ind + ">\n"
        let mut ci: int = 0
        while ci < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[ci], depth + 1) + "\n"
            ci = ci + 1
        xml = xml + ind + "</androidx.cardview.widget.CardView>"
        return xml

    // 13: Toggle / Switch -> SwitchCompat
    if k == 13:
        let mut xml: string = ind + "<androidx.appcompat.widget.SwitchCompat\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:text=\"" + w.text + "\"\n"
        if w.is_checked:
            xml = xml + ind + "    android:checked=\"true\"\n"
        xml = xml + ind + "/>"
        return xml

    // 14: ProgressBar -> ProgressBar (Horizontal)
    if k == 14:
        let mut xml: string = ind + "<ProgressBar\n"
        xml = xml + ind + "    style=\"?android:attr/progressBarStyleHorizontal\"\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"" + str(w.height) + "dp\"\n"
        xml = xml + ind + "    android:progress=\"" + str(w.value) + "\"\n"
        xml = xml + ind + "    android:max=\"100\"\n"
        xml = xml + ind + "/>"
        return xml

    return ind + "<!-- Unsupported widget: " + str(k) + " -->"

fn render_activity_layout_xml(root_widget: Widget) -> string:
    let mut xml: string = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
    xml = xml + "<androidx.constraintlayout.widget.ConstraintLayout\n"
    xml = xml + "    xmlns:android=\"http://schemas.android.com/apk/res/android\"\n"
    xml = xml + "    xmlns:app=\"http://schemas.android.com/apk/res-auto\"\n"
    xml = xml + "    android:layout_width=\"match_parent\"\n"
    xml = xml + "    android:layout_height=\"match_parent\"\n"
    xml = xml + "    android:background=\"#0d1117\">\n\n"
    xml = xml + render_widget_to_android_xml(root_widget, 1) + "\n\n"
    xml = xml + "</androidx.constraintlayout.widget.ConstraintLayout>"
    return xml
