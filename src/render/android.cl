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

    // 12: Badge / Chip -> com.google.android.material.chip.Chip
    if k == 12:
        let mut xml: string = ind + "<com.google.android.material.chip.Chip\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:text=\"" + w.text + "\"\n"
        xml = xml + ind + "    android:textColor=\"" + w.color + "\"\n"
        xml = xml + ind + "    app:chipBackgroundColor=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    android:textSize=\"" + str(w.font_size) + "sp\"\n"
        xml = xml + ind + "/>"
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

    // 15: ListTile -> LinearLayout (Horizontal with Icon/Content)
    if k == 15:
        let mut xml: string = ind + "<LinearLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:orientation=\"horizontal\"\n"
        xml = xml + ind + "    android:gravity=\"center_vertical\"\n"
        xml = xml + ind + "    android:padding=\"12dp\"\n"
        xml = xml + ind + ">\n"
        if len(w.icon_name) > 0:
            xml = xml + ind + "    <TextView\n"
            xml = xml + ind + "        android:layout_width=\"wrap_content\"\n"
            xml = xml + ind + "        android:layout_height=\"wrap_content\"\n"
            xml = xml + ind + "        android:text=\"" + w.icon_name + "\"\n"
            xml = xml + ind + "        android:textSize=\"20sp\"\n"
            xml = xml + ind + "        android:layout_marginEnd=\"16dp\"/>\n"
        xml = xml + ind + "    <LinearLayout\n"
        xml = xml + ind + "        android:layout_width=\"0dp\"\n"
        xml = xml + ind + "        android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "        android:layout_weight=\"1\"\n"
        xml = xml + ind + "        android:orientation=\"vertical\">\n"
        xml = xml + ind + "        <TextView\n"
        xml = xml + ind + "            android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "            android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "            android:text=\"" + w.text + "\"\n"
        xml = xml + ind + "            android:textSize=\"15sp\"\n"
        xml = xml + ind + "            android:textStyle=\"bold\"\n"
        xml = xml + ind + "            android:textColor=\"#e6edf3\"/>\n"
        if len(w.subtitle) > 0:
            xml = xml + ind + "        <TextView\n"
            xml = xml + ind + "            android:layout_width=\"wrap_content\"\n"
            xml = xml + ind + "            android:layout_height=\"wrap_content\"\n"
            xml = xml + ind + "            android:text=\"" + w.subtitle + "\"\n"
            xml = xml + ind + "            android:textSize=\"13sp\"\n"
            xml = xml + ind + "            android:textColor=\"#8b949e\"/>\n"
        xml = xml + ind + "    </LinearLayout>\n"
        xml = xml + ind + "</LinearLayout>"
        return xml

    // 16: Center -> FrameLayout with layout_gravity="center"
    if k == 16:
        let mut xml: string = ind + "<FrameLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:foregroundGravity=\"center\">\n"
        let mut cti: int = 0
        while cti < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[cti], depth + 1) + "\n"
            cti = cti + 1
        xml = xml + ind + "</FrameLayout>"
        return xml

    // 17: Link -> TextView styled as link
    if k == 17:
        let mut xml: string = ind + "<TextView\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:text=\"" + w.text + "\"\n"
        xml = xml + ind + "    android:textSize=\"" + str(w.font_size) + "sp\"\n"
        xml = xml + ind + "    android:textColor=\"" + w.color + "\"\n"
        xml = xml + ind + "    android:autoLink=\"web\"\n"
        xml = xml + ind + "/>"
        return xml

    // 18: Expanded -> FrameLayout with layout_weight
    if k == 18:
        let mut xml: string = ind + "<FrameLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"0dp\"\n"
        xml = xml + ind + "    android:layout_weight=\"" + str(w.flex) + "\">\n"
        let mut exi: int = 0
        while exi < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[exi], depth + 1) + "\n"
            exi = exi + 1
        xml = xml + ind + "</FrameLayout>"
        return xml

    // 19: AppBar -> com.google.android.material.appbar.MaterialToolbar
    if k == 19:
        let mut xml: string = ind + "<com.google.android.material.appbar.MaterialToolbar\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"?attr/actionBarSize\"\n"
        xml = xml + ind + "    android:background=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    app:title=\"" + w.text + "\"\n"
        xml = xml + ind + "    app:titleTextColor=\"#e6edf3\"\n"
        xml = xml + ind + "/>"
        return xml

    // 20: BottomNavigationBar -> com.google.android.material.bottomnavigation.BottomNavigationView
    if k == 20:
        let mut xml: string = ind + "<com.google.android.material.bottomnavigation.BottomNavigationView\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:background=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    app:itemTextColor=\"#8b949e\"\n"
        xml = xml + ind + "    app:itemIconTint=\"#8b949e\"\n"
        xml = xml + ind + "/>"
        return xml

    // 21: TabItem -> com.google.android.material.tabs.TabItem
    if k == 21:
        let mut xml: string = ind + "<com.google.android.material.tabs.TabItem\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:text=\"" + w.text + "\"\n"
        xml = xml + ind + "/>"
        return xml

    // 22: FloatingActionButton -> com.google.android.material.floatingactionbutton.FloatingActionButton
    if k == 22:
        let mut xml: string = ind + "<com.google.android.material.floatingactionbutton.FloatingActionButton\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:backgroundTint=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    app:tint=\"#ffffff\"\n"
        xml = xml + ind + "    android:contentDescription=\"" + w.icon_name + "\"\n"
        xml = xml + ind + "/>"
        return xml

    // 23: Dialog -> CardView container (Dialog style)
    if k == 23:
        let mut xml: string = ind + "<androidx.cardview.widget.CardView\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    app:cardCornerRadius=\"14dp\"\n"
        xml = xml + ind + "    app:cardBackgroundColor=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    app:cardElevation=\"16dp\"\n"
        xml = xml + ind + ">\n"
        let mut di: int = 0
        while di < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[di], depth + 1) + "\n"
            di = di + 1
        xml = xml + ind + "</androidx.cardview.widget.CardView>"
        return xml

    // 24: SnackBar -> LinearLayout
    if k == 24:
        let mut xml: string = ind + "<LinearLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:orientation=\"horizontal\"\n"
        xml = xml + ind + "    android:background=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    android:padding=\"12dp\"\n"
        xml = xml + ind + ">\n"
        xml = xml + ind + "    <TextView\n"
        xml = xml + ind + "        android:layout_width=\"0dp\"\n"
        xml = xml + ind + "        android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "        android:layout_weight=\"1\"\n"
        xml = xml + ind + "        android:text=\"" + w.text + "\"\n"
        xml = xml + ind + "        android:textColor=\"#f0f6fc\"/>\n"
        if len(w.subtitle) > 0:
            xml = xml + ind + "    <TextView\n"
            xml = xml + ind + "        android:layout_width=\"wrap_content\"\n"
            xml = xml + ind + "        android:layout_height=\"wrap_content\"\n"
            xml = xml + ind + "        android:text=\"" + w.subtitle + "\"\n"
            xml = xml + ind + "        android:textColor=\"#58a6ff\"/>\n"
        xml = xml + ind + "</LinearLayout>"
        return xml

    // 25: Grid -> GridLayout
    if k == 25:
        let mut xml: string = ind + "<GridLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:columnCount=\"" + str(w.columns) + "\"\n"
        xml = xml + ind + ">\n"
        let mut gri: int = 0
        while gri < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[gri], depth + 1) + "\n"
            gri = gri + 1
        xml = xml + ind + "</GridLayout>"
        return xml

    // 26: Wrap -> com.google.android.flexbox.FlexboxLayout
    if k == 26:
        let mut xml: string = ind + "<com.google.android.flexbox.FlexboxLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    app:flexWrap=\"wrap\"\n"
        xml = xml + ind + "    app:alignItems=\"center\"\n"
        xml = xml + ind + ">\n"
        let mut wpi: int = 0
        while wpi < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[wpi], depth + 1) + "\n"
            wpi = wpi + 1
        xml = xml + ind + "</com.google.android.flexbox.FlexboxLayout>"
        return xml

    // 27: Avatar -> CardView circular avatar
    if k == 27:
        let mut xml: string = ind + "<androidx.cardview.widget.CardView\n"
        xml = xml + ind + "    android:layout_width=\"" + str(w.width) + "dp\"\n"
        xml = xml + ind + "    android:layout_height=\"" + str(w.height) + "dp\"\n"
        xml = xml + ind + "    app:cardCornerRadius=\"" + str(w.border_radius) + "dp\"\n"
        xml = xml + ind + "    app:cardBackgroundColor=\"" + w.bg_color + "\"\n"
        xml = xml + ind + ">\n"
        xml = xml + ind + "    <TextView\n"
        xml = xml + ind + "        android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "        android:layout_height=\"match_parent\"\n"
        xml = xml + ind + "        android:gravity=\"center\"\n"
        xml = xml + ind + "        android:text=\"" + w.text + "\"\n"
        xml = xml + ind + "        android:textColor=\"#ffffff\"\n"
        xml = xml + ind + "        android:textStyle=\"bold\"/>\n"
        xml = xml + ind + "</androidx.cardview.widget.CardView>"
        return xml

    // 28: Dropdown -> Spinner
    if k == 28:
        let mut xml: string = ind + "<Spinner\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:backgroundTint=\"" + w.color + "\"\n"
        xml = xml + ind + "/>"
        return xml

    // 29: Scaffold -> CoordinatorLayout
    if k == 29:
        let mut xml: string = ind + "<androidx.coordinatorlayout.widget.CoordinatorLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"match_parent\"\n"
        xml = xml + ind + "    android:background=\"" + w.bg_color + "\"\n"
        xml = xml + ind + ">\n"
        let mut sci: int = 0
        while sci < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[sci], depth + 1) + "\n"
            sci = sci + 1
        xml = xml + ind + "</androidx.coordinatorlayout.widget.CoordinatorLayout>"
        return xml

    // 30: ScrollView -> NestedScrollView
    if k == 30:
        let mut xml: string = ind + "<androidx.core.widget.NestedScrollView\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"match_parent\"\n"
        xml = xml + ind + "    android:fillViewport=\"true\"\n"
        xml = xml + ind + ">\n"
        if len(w.children) > 0:
            xml = xml + render_widget_to_android_xml(w.children[0], depth + 1) + "\n"
        xml = xml + ind + "</androidx.core.widget.NestedScrollView>"
        return xml

    // 31: Slider -> com.google.android.material.slider.Slider
    if k == 31:
        let mut xml: string = ind + "<com.google.android.material.slider.Slider\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:valueFrom=\"" + str(w.min_value) + ".0\"\n"
        xml = xml + ind + "    android:valueTo=\"" + str(w.max_value) + ".0\"\n"
        xml = xml + ind + "    android:value=\"" + str(w.value) + ".0\"\n"
        xml = xml + ind + "    app:thumbColor=\"" + w.color + "\"\n"
        xml = xml + ind + "    app:trackColorActive=\"" + w.color + "\"\n"
        xml = xml + ind + "/>"
        return xml

    // 32: Checkbox -> MaterialCheckBox
    if k == 32:
        let mut xml: string = ind + "<com.google.android.material.checkbox.MaterialCheckBox\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:text=\"" + w.text + "\"\n"
        xml = xml + ind + "    android:textColor=\"#e6edf3\"\n"
        if w.is_checked:
            xml = xml + ind + "    android:checked=\"true\"\n"
        xml = xml + ind + "    app:buttonTint=\"" + w.color + "\"\n"
        xml = xml + ind + "/>"
        return xml

    // 33: Radio -> MaterialRadioButton
    if k == 33:
        let mut xml: string = ind + "<com.google.android.material.radiobutton.MaterialRadioButton\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:text=\"" + w.text + "\"\n"
        xml = xml + ind + "    android:textColor=\"#e6edf3\"\n"
        if w.is_checked:
            xml = xml + ind + "    android:checked=\"true\"\n"
        xml = xml + ind + "    app:buttonTint=\"" + w.color + "\"\n"
        xml = xml + ind + "/>"
        return xml

    // 34: Chip -> Chip
    if k == 34:
        let mut xml: string = ind + "<com.google.android.material.chip.Chip\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:text=\"" + w.text + "\"\n"
        xml = xml + ind + "    app:chipBackgroundColor=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    android:textColor=\"" + w.color + "\"\n"
        if len(w.on_delete) > 0:
            xml = xml + ind + "    app:closeIconVisible=\"true\"\n"
        xml = xml + ind + "/>"
        return xml

    // 35: CircularProgressIndicator
    if k == 35:
        let mut xml: string = ind + "<com.google.android.material.progressindicator.CircularProgressIndicator\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:indeterminate=\"true\"\n"
        xml = xml + ind + "    app:indicatorColor=\"" + w.color + "\"\n"
        xml = xml + ind + "    app:indicatorSize=\"" + str(w.width) + "dp\"\n"
        xml = xml + ind + "    app:trackThickness=\"" + str(w.border_width) + "dp\"\n"
        xml = xml + ind + "/>"
        return xml

    // 36: Drawer -> NavigationView
    if k == 36:
        let mut xml: string = ind + "<com.google.android.material.navigation.NavigationView\n"
        xml = xml + ind + "    android:layout_width=\"280dp\"\n"
        xml = xml + ind + "    android:layout_height=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_gravity=\"start\"\n"
        xml = xml + ind + "    android:background=\"" + w.bg_color + "\"\n"
        xml = xml + ind + ">\n"
        let mut d_ind: int = 0
        while d_ind < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[d_ind], depth + 1) + "\n"
            d_ind = d_ind + 1
        xml = xml + ind + "</com.google.android.material.navigation.NavigationView>"
        return xml

    // 37: BottomSheet -> FrameLayout with bottomSheetBehavior
    if k == 37:
        let mut xml: string = ind + "<FrameLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    app:layout_behavior=\"com.google.android.material.bottomsheet.BottomSheetBehavior\"\n"
        xml = xml + ind + "    android:background=\"" + w.bg_color + "\"\n"
        xml = xml + ind + ">\n"
        if len(w.children) > 0:
            xml = xml + render_widget_to_android_xml(w.children[0], depth + 1) + "\n"
        xml = xml + ind + "</FrameLayout>"
        return xml

    // 38: ExpansionTile -> LinearLayout
    if k == 38:
        let mut xml: string = ind + "<LinearLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:orientation=\"vertical\"\n"
        xml = xml + ind + "    android:background=\"" + w.bg_color + "\"\n"
        xml = xml + ind + ">\n"
        xml = xml + ind + "    <TextView android:layout_width=\"wrap_content\" android:layout_height=\"wrap_content\" android:text=\"" + w.text + "\" android:textStyle=\"bold\" android:textColor=\"#e6edf3\" />\n"
        let mut ei: int = 0
        while ei < len(w.children):
            xml = xml + render_widget_to_android_xml(w.children[ei], depth + 1) + "\n"
            ei = ei + 1
        xml = xml + ind + "</LinearLayout>"
        return xml

    // 39: Alert -> MaterialCardView
    if k == 39:
        let mut xml: string = ind + "<com.google.android.material.card.MaterialCardView\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    app:cardBackgroundColor=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    app:strokeColor=\"" + w.color + "\"\n"
        xml = xml + ind + "    app:strokeWidth=\"1dp\"\n"
        xml = xml + ind + "    app:cardCornerRadius=\"8dp\"\n"
        xml = xml + ind + ">\n"
        xml = xml + ind + "    <LinearLayout android:layout_width=\"match_parent\" android:layout_height=\"wrap_content\" android:orientation=\"vertical\" android:padding=\"12dp\">\n"
        xml = xml + ind + "        <TextView android:layout_width=\"wrap_content\" android:layout_height=\"wrap_content\" android:text=\"" + w.text + "\" android:textStyle=\"bold\" android:textColor=\"" + w.color + "\" />\n"
        if len(w.subtitle) > 0:
            xml = xml + ind + "        <TextView android:layout_width=\"wrap_content\" android:layout_height=\"wrap_content\" android:text=\"" + w.subtitle + "\" android:textColor=\"#e6edf3\" android:textSize=\"13sp\" />\n"
        xml = xml + ind + "    </LinearLayout>\n"
        xml = xml + ind + "</com.google.android.material.card.MaterialCardView>"
        return xml

    // 40: Icon -> ImageView
    if k == 40:
        let mut xml: string = ind + "<ImageView\n"
        xml = xml + ind + "    android:layout_width=\"" + str(w.font_size) + "dp\"\n"
        xml = xml + ind + "    android:layout_height=\"" + str(w.font_size) + "dp\"\n"
        xml = xml + ind + "    android:src=\"@drawable/ic_" + w.icon_name + "\"\n"
        xml = xml + ind + "    app:tint=\"" + w.color + "\"\n"
        xml = xml + ind + "/>"
        return xml

    // 41: Stepper -> LinearLayout with minus/value/plus
    if k == 41:
        let mut xml: string = ind + "<LinearLayout\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:orientation=\"horizontal\"\n"
        xml = xml + ind + "    android:gravity=\"center_vertical\"\n"
        xml = xml + ind + "    android:background=\"@drawable/stepper_bg\"\n"
        xml = xml + ind + "    android:padding=\"4dp\"\n"
        xml = xml + ind + ">\n"
        if len(w.text) > 0:
            xml = xml + ind + "    <TextView android:layout_width=\"wrap_content\" android:layout_height=\"wrap_content\" android:text=\"" + w.text + "\" android:textColor=\"#e6edf3\" android:layout_marginEnd=\"8dp\" />\n"
        xml = xml + ind + "    <com.google.android.material.button.MaterialButton style=\"@style/Widget.Material3.Button.IconButton\" android:layout_width=\"32dp\" android:layout_height=\"32dp\" android:text=\"-\" />\n"
        xml = xml + ind + "    <TextView android:layout_width=\"wrap_content\" android:layout_height=\"wrap_content\" android:text=\"" + str(w.value) + "\" android:textStyle=\"bold\" android:textColor=\"" + w.color + "\" android:paddingHorizontal=\"8dp\" />\n"
        xml = xml + ind + "    <com.google.android.material.button.MaterialButton style=\"@style/Widget.Material3.Button.IconButton\" android:layout_width=\"32dp\" android:layout_height=\"32dp\" android:text=\"+\" />\n"
        xml = xml + ind + "</LinearLayout>"
        return xml

    // 42: SegmentedButton -> MaterialButtonToggleGroup
    if k == 42:
        let mut xml: string = ind + "<com.google.android.material.button.MaterialButtonToggleGroup\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    app:singleSelection=\"true\"\n"
        xml = xml + ind + ">\n"
        let mut sgi: int = 0
        while sgi < len(w.options):
            let mut chk: string = ""
            if sgi == w.active_index:
                chk = " android:checked=\"true\""
            xml = xml + ind + "    <com.google.android.material.button.MaterialButton style=\"@style/Widget.Material3.Button.OutlinedButton\" android:layout_width=\"wrap_content\" android:layout_height=\"wrap_content\" android:text=\"" + w.options[sgi] + "\"" + chk + " />\n"
            sgi = sgi + 1
        xml = xml + ind + "</com.google.android.material.button.MaterialButtonToggleGroup>"
        return xml

    // 43: Tooltip -> FrameLayout with tooltipText
    if k == 43:
        let mut xml: string = ind + "<FrameLayout\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:tooltipText=\"" + w.text + "\"\n"
        xml = xml + ind + ">\n"
        if len(w.children) > 0:
            xml = xml + render_widget_to_android_xml(w.children[0], depth + 1) + "\n"
        xml = xml + ind + "</FrameLayout>"
        return xml

    // 44: NavigationRail -> NavigationRailView
    if k == 44:
        let mut xml: string = ind + "<com.google.android.material.navigationrail.NavigationRailView\n"
        xml = xml + ind + "    android:layout_width=\"" + str(w.width) + "dp\"\n"
        xml = xml + ind + "    android:layout_height=\"match_parent\"\n"
        xml = xml + ind + "    android:background=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    app:menu=\"@menu/rail_menu\"\n"
        xml = xml + ind + "/>"
        return xml

    // 45: DataTable -> TableLayout
    if k == 45:
        let mut xml: string = ind + "<TableLayout\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:background=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    android:stretchColumns=\"*\"\n"
        xml = xml + ind + ">\n"
        xml = xml + ind + "    <TableRow android:background=\"#21262d\" android:padding=\"8dp\">\n"
        let mut hi: int = 0
        while hi < len(w.options):
            xml = xml + ind + "        <TextView android:text=\"" + w.options[hi] + "\" android:textStyle=\"bold\" android:textColor=\"#8b949e\" android:padding=\"6dp\" />\n"
            hi = hi + 1
        xml = xml + ind + "    </TableRow>\n"
        let mut ri: int = 0
        while ri < len(w.children):
            let row_w: Widget = w.children[ri]
            xml = xml + ind + "    <TableRow android:padding=\"8dp\">\n"
            let mut ci: int = 0
            while ci < len(row_w.children):
                xml = xml + render_widget_to_android_xml(row_w.children[ci], depth + 2) + "\n"
                ci = ci + 1
            xml = xml + ind + "    </TableRow>\n"
            ri = ri + 1
        xml = xml + ind + "</TableLayout>"
        return xml

    // 46: Rating -> RatingBar
    if k == 46:
        let mut xml: string = ind + "<RatingBar\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:numStars=\"" + str(w.max_value) + "\"\n"
        xml = xml + ind + "    android:rating=\"" + str(w.value) + ".0\"\n"
        xml = xml + ind + "    android:stepSize=\"1.0\"\n"
        xml = xml + ind + "    android:progressTint=\"" + w.color + "\"\n"
        xml = xml + ind + "/>"
        return xml

    // 47: Skeleton -> View placeholder
    if k == 47:
        let mut xml: string = ind + "<View\n"
        xml = xml + ind + "    android:layout_width=\"" + str(w.width) + "dp\"\n"
        xml = xml + ind + "    android:layout_height=\"" + str(w.height) + "dp\"\n"
        xml = xml + ind + "    android:background=\"@drawable/skeleton_placeholder\"\n"
        xml = xml + ind + "/>"
        return xml

    // 48: Breadcrumbs -> HorizontalScrollView
    if k == 48:
        let mut xml: string = ind + "<HorizontalScrollView\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    android:scrollbars=\"none\"\n"
        xml = xml + ind + ">\n"
        xml = xml + ind + "    <LinearLayout android:layout_width=\"wrap_content\" android:layout_height=\"wrap_content\" android:orientation=\"horizontal\" android:gravity=\"center_vertical\">\n"
        let mut bci: int = 0
        while bci < len(w.options):
            if bci > 0:
                xml = xml + ind + "        <TextView android:text=\"/\" android:textColor=\"#484f58\" android:paddingHorizontal=\"4dp\" />\n"
            xml = xml + ind + "        <TextView android:text=\"" + w.options[bci] + "\" android:textColor=\"" + w.color + "\" />\n"
            bci = bci + 1
        xml = xml + ind + "    </LinearLayout>\n"
        xml = xml + ind + "</HorizontalScrollView>"
        return xml

    // 49: CodeBlock -> NestedScrollView with monospaced TextView
    if k == 49:
        let mut xml: string = ind + "<com.google.android.material.card.MaterialCardView\n"
        xml = xml + ind + "    android:layout_width=\"match_parent\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    app:cardBackgroundColor=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    app:strokeColor=\"#30363d\"\n"
        xml = xml + ind + "    app:strokeWidth=\"1dp\"\n"
        xml = xml + ind + "    app:cardCornerRadius=\"" + str(w.border_radius) + "dp\"\n"
        xml = xml + ind + ">\n"
        xml = xml + ind + "    <HorizontalScrollView android:layout_width=\"match_parent\" android:layout_height=\"wrap_content\">\n"
        xml = xml + ind + "        <TextView android:text=\"" + w.text + "\" android:fontFamily=\"monospace\" android:textColor=\"" + w.color + "\" android:padding=\"" + str(w.padding) + "dp\" />\n"
        xml = xml + ind + "    </HorizontalScrollView>\n"
        xml = xml + ind + "</com.google.android.material.card.MaterialCardView>"
        return xml

    // 50: MetricCard -> MaterialCardView KPI
    if k == 50:
        let mut xml: string = ind + "<com.google.android.material.card.MaterialCardView\n"
        xml = xml + ind + "    android:layout_width=\"wrap_content\"\n"
        xml = xml + ind + "    android:layout_height=\"wrap_content\"\n"
        xml = xml + ind + "    app:cardBackgroundColor=\"" + w.bg_color + "\"\n"
        xml = xml + ind + "    app:strokeColor=\"#30363d\"\n"
        xml = xml + ind + "    app:strokeWidth=\"1dp\"\n"
        xml = xml + ind + "    app:cardCornerRadius=\"" + str(w.border_radius) + "dp\"\n"
        xml = xml + ind + ">\n"
        xml = xml + ind + "    <LinearLayout android:layout_width=\"wrap_content\" android:layout_height=\"wrap_content\" android:orientation=\"vertical\" android:padding=\"" + str(w.padding) + "dp\">\n"
        xml = xml + ind + "        <TextView android:text=\"" + w.text + "\" android:textColor=\"#8b949e\" android:textSize=\"13sp\" />\n"
        xml = xml + ind + "        <TextView android:text=\"" + w.value_str + "\" android:textColor=\"#e6edf3\" android:textSize=\"22sp\" android:textStyle=\"bold\" />\n"
        if len(w.subtitle) > 0:
            let mut tcol: string = "#f85149"
            if w.is_checked:
                tcol = "#3fb950"
            xml = xml + ind + "        <TextView android:text=\"" + w.subtitle + "\" android:textColor=\"" + tcol + "\" android:textSize=\"12sp\" />\n"
        xml = xml + ind + "    </LinearLayout>\n"
        xml = xml + ind + "</com.google.android.material.card.MaterialCardView>"
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
