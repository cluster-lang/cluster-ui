// ==============================================================================
// Cluster UI: Native Apple SwiftUI Code Generator
// Translates Cluster UI Declarative Widget Tree directly into Native SwiftUI View
// Pure Cluster Language — 100% Zero Dependencies, 0 Node, 0 Pods
// ==============================================================================

import src/core/widget.cl

fn swift_indent(level: int) -> string:
    let mut s: string = ""
    let mut i: int = 0
    while i < level:
        s = s + "    "
        i = i + 1
    return s

fn render_widget_to_swiftui(w: Widget, depth: int = 1) -> string:
    let k: int = w.kind
    let ind: string = swift_indent(depth)

    // 1: Text
    if k == 1:
        let mut code: string = ind + "Text(\"" + w.text + "\")"
        if w.font_size > 0:
            code = code + "\n" + ind + "    .font(.system(size: " + str(w.font_size) + "))"
        if w.bold:
            code = code + "\n" + ind + "    .fontWeight(.bold)"
        if len(w.color) > 0:
            code = code + "\n" + ind + "    .foregroundColor(Color(hex: \"" + w.color + "\"))"
        return code

    // 2: Button
    if k == 2:
        let mut code: string = ind + "Button(action: { /* " + w.on_click + " */ }) {\n"
        code = code + ind + "    Text(\"" + w.text + "\")\n"
        code = code + ind + "        .fontWeight(.semibold)\n"
        code = code + ind + "        .padding(.horizontal, 16)\n"
        code = code + ind + "        .padding(.vertical, 8)\n"
        code = code + ind + "        .background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + "        .foregroundColor(Color(hex: \"" + w.color + "\"))\n"
        code = code + ind + "        .cornerRadius(" + str(w.border_radius) + ")\n"
        code = code + ind + "}"
        return code

    // 3: Column / VStack
    if k == 3:
        let mut code: string = ind + "VStack(spacing: " + str(w.spacing) + ") {\n"
        let mut i: int = 0
        while i < len(w.children):
            code = code + render_widget_to_swiftui(w.children[i], depth + 1) + "\n"
            i = i + 1
        code = code + ind + "}"
        if w.padding > 0:
            code = code + "\n" + ind + ".padding(" + str(w.padding) + ")"
        return code

    // 4: Row / HStack
    if k == 4:
        let mut code: string = ind + "HStack(spacing: " + str(w.spacing) + ") {\n"
        let mut j: int = 0
        while j < len(w.children):
            code = code + render_widget_to_swiftui(w.children[j], depth + 1) + "\n"
            j = j + 1
        code = code + ind + "}"
        if w.padding > 0:
            code = code + "\n" + ind + ".padding(" + str(w.padding) + ")"
        return code

    // 5: Box / Container
    if k == 5:
        let mut code: string = ind + "VStack {\n"
        let mut bi: int = 0
        while bi < len(w.children):
            code = code + render_widget_to_swiftui(w.children[bi], depth + 1) + "\n"
            bi = bi + 1
        code = code + ind + "}"
        if w.width > 0 or w.height > 0:
            code = code + "\n" + ind + ".frame("
            if w.width > 0:
                code = code + "width: " + str(w.width)
            if w.height > 0:
                if w.width > 0:
                    code = code + ", "
                code = code + "height: " + str(w.height)
            code = code + ")"
        if len(w.bg_color) > 0:
            code = code + "\n" + ind + ".background(Color(hex: \"" + w.bg_color + "\"))"
        if w.border_radius > 0:
            code = code + "\n" + ind + ".cornerRadius(" + str(w.border_radius) + ")"
        return code

    // 6: Spacer
    if k == 6:
        return ind + "Spacer()"

    // 7: TextInput
    if k == 7:
        let mut code: string = ind + "TextField(\"" + w.placeholder + "\", text: $inputText)\n"
        code = code + ind + "    .textFieldStyle(RoundedBorderTextFieldStyle())\n"
        code = code + ind + "    .padding(" + str(w.padding) + ")"
        return code

    // 8: Image
    if k == 8:
        let mut code: string = ind + "AsyncImage(url: URL(string: \"" + w.image_url + "\")) {\n"
        code = code + ind + "    image in image.resizable().scaledToFit()\n"
        code = code + ind + "} placeholder: {\n"
        code = code + ind + "    ProgressView()\n"
        code = code + ind + "}"
        if w.width > 0 or w.height > 0:
            code = code + "\n" + ind + ".frame(width: " + str(w.width) + ", height: " + str(w.height) + ")"
        return code

    // 9: ZStack
    if k == 9:
        let mut code: string = ind + "ZStack {\n"
        let mut zi: int = 0
        while zi < len(w.children):
            code = code + render_widget_to_swiftui(w.children[zi], depth + 1) + "\n"
            zi = zi + 1
        code = code + ind + "}"
        return code

    // 10: Divider
    if k == 10:
        return ind + "Divider()"

    // 11: Card
    if k == 11:
        let mut code: string = ind + "VStack {\n"
        let mut ci: int = 0
        while ci < len(w.children):
            code = code + render_widget_to_swiftui(w.children[ci], depth + 1) + "\n"
            ci = ci + 1
        code = code + ind + "}\n"
        code = code + ind + ".padding(" + str(w.padding) + ")\n"
        code = code + ind + ".background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + ".cornerRadius(" + str(w.border_radius) + ")\n"
        code = code + ind + ".shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 3)"
        return code

    // 12: Badge / Chip
    if k == 12:
        let mut code: string = ind + "Text(\"" + w.text + "\")\n"
        code = code + ind + "    .font(.system(size: " + str(w.font_size) + ", weight: .bold))\n"
        code = code + ind + "    .foregroundColor(Color(hex: \"" + w.color + "\"))\n"
        code = code + ind + "    .padding(.horizontal, 10)\n"
        code = code + ind + "    .padding(.vertical, 4)\n"
        code = code + ind + "    .background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + "    .cornerRadius(" + str(w.border_radius) + ")"
        return code

    // 13: Toggle / Switch
    if k == 13:
        return ind + "Toggle(\"" + w.text + "\", isOn: $toggleState)"

    // 14: ProgressBar
    if k == 14:
        return ind + "ProgressView(value: " + str(w.value) + ".0, total: 100.0)\n" + ind + "    .accentColor(Color(hex: \"" + w.color + "\"))"

    // 15: ListTile
    if k == 15:
        let mut code: string = ind + "HStack(spacing: 14) {\n"
        if len(w.icon_name) > 0:
            code = code + ind + "    Text(\"" + w.icon_name + "\").font(.title2)\n"
        code = code + ind + "    VStack(alignment: .leading, spacing: 2) {\n"
        code = code + ind + "        Text(\"" + w.text + "\").fontWeight(.bold)\n"
        if len(w.subtitle) > 0:
            code = code + ind + "        Text(\"" + w.subtitle + "\").font(.subheadline).foregroundColor(.secondary)\n"
        code = code + ind + "    }\n"
        code = code + ind + "    Spacer()\n"
        code = code + ind + "}"
        return code

    // 16: Center
    if k == 16:
        let mut code: string = ind + "VStack {\n"
        code = code + ind + "    Spacer()\n"
        code = code + ind + "    HStack {\n"
        code = code + ind + "        Spacer()\n"
        if len(w.children) > 0:
            code = code + render_widget_to_swiftui(w.children[0], depth + 2) + "\n"
        code = code + ind + "        Spacer()\n"
        code = code + ind + "    }\n"
        code = code + ind + "    Spacer()\n"
        code = code + ind + "}"
        return code

    // 17: Link
    if k == 17:
        return ind + "Link(\"" + w.text + "\", destination: URL(string: \"" + w.url + "\")!)"

    // 18: Expanded
    if k == 18:
        let mut code: string = ""
        if len(w.children) > 0:
            code = render_widget_to_swiftui(w.children[0], depth) + "\n" + ind + ".frame(maxWidth: .infinity, maxHeight: .infinity)"
        return code

    // 19: AppBar
    if k == 19:
        let mut code: string = ind + "HStack {\n"
        if len(w.children) > 0:
            code = code + render_widget_to_swiftui(w.children[0], depth + 1) + "\n"
        code = code + ind + "    Text(\"" + w.text + "\").font(.headline).fontWeight(.bold)\n"
        code = code + ind + "    Spacer()\n"
        if len(w.children) > 1:
            code = code + render_widget_to_swiftui(w.children[1], depth + 1) + "\n"
        code = code + ind + "}\n"
        code = code + ind + ".padding()\n"
        code = code + ind + ".background(Color(hex: \"" + w.bg_color + "\"))"
        return code

    // 20: BottomNavigationBar
    if k == 20:
        let mut code: string = ind + "TabView {\n"
        let mut tbi: int = 0
        while tbi < len(w.children):
            code = code + render_widget_to_swiftui(w.children[tbi], depth + 1) + "\n"
            tbi = tbi + 1
        code = code + ind + "}"
        return code

    // 21: TabItem
    if k == 21:
        return ind + "Text(\"" + w.text + "\").tabItem {\n" + ind + "    Text(\"" + w.icon_name + "\")\n" + ind + "    Text(\"" + w.text + "\")\n" + ind + "}"

    // 22: FloatingActionButton
    if k == 22:
        let mut code: string = ind + "Button(action: { /* " + w.on_click + " */ }) {\n"
        code = code + ind + "    Text(\"" + w.icon_name + "\")\n"
        code = code + ind + "        .font(.title)\n"
        code = code + ind + "        .foregroundColor(.white)\n"
        code = code + ind + "        .frame(width: 56, height: 56)\n"
        code = code + ind + "        .background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + "        .clipShape(Circle())\n"
        code = code + ind + "        .shadow(radius: 6)\n"
        code = code + ind + "}"
        return code

    // 25: Grid
    if k == 25:
        let mut code: string = ind + "LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: " + str(w.spacing) + "), count: " + str(w.columns) + "), spacing: " + str(w.spacing) + ") {\n"
        let mut gri: int = 0
        while gri < len(w.children):
            code = code + render_widget_to_swiftui(w.children[gri], depth + 1) + "\n"
            gri = gri + 1
        code = code + ind + "}"
        return code

    // 27: Avatar
    if k == 27:
        let mut code: string = ind + "ZStack {\n"
        code = code + ind + "    Circle().fill(Color(hex: \"" + w.bg_color + "\")).frame(width: " + str(w.width) + ", height: " + str(w.height) + ")\n"
        code = code + ind + "    Text(\"" + w.text + "\").font(.headline).foregroundColor(.white)\n"
        if w.is_online:
            code = code + ind + "    Circle().fill(Color.green).frame(width: 10, height: 10).offset(x: " + str(w.width / 3) + ", y: " + str(w.height / 3) + ")\n"
        code = code + ind + "}"
        return code

    // 29: Scaffold
    if k == 29:
        let mut code: string = ind + "VStack(spacing: 0) {\n"
        if len(w.children) > 0:
            code = code + render_widget_to_swiftui(w.children[0], depth + 1) + "\n"
        if len(w.children) > 1:
            code = code + render_widget_to_swiftui(w.children[1], depth + 1) + "\n"
        if len(w.children) > 2:
            code = code + render_widget_to_swiftui(w.children[2], depth + 1) + "\n"
        code = code + ind + "}\n"
        code = code + ind + ".background(Color(hex: \"" + w.bg_color + "\").ignoresSafeArea())"
        return code

    // 30: ScrollView
    if k == 30:
        let mut code: string = ind + "ScrollView {\n"
        if len(w.children) > 0:
            code = code + render_widget_to_swiftui(w.children[0], depth + 1) + "\n"
        code = code + ind + "}"
        return code

    // 31: Slider
    if k == 31:
        let mut code: string = ind + "Slider(value: .constant(" + str(w.value) + ".0), in: " + str(w.min_value) + ".0..." + str(w.max_value) + ".0)\n"
        code = code + ind + "    .accentColor(Color(hex: \"" + w.color + "\"))"
        return code

    // 32: Checkbox
    if k == 32:
        let mut chk_val: string = "false"
        if w.is_checked:
            chk_val = "true"
        let mut code: string = ind + "Toggle(isOn: .constant(" + chk_val + ")) {\n"
        code = code + ind + "    Text(\"" + w.text + "\")\n"
        code = code + ind + "        .foregroundColor(Color(hex: \"#e6edf3\"))\n"
        code = code + ind + "}\n"
        code = code + ind + ".toggleStyle(.checkbox)\n"
        code = code + ind + ".accentColor(Color(hex: \"" + w.color + "\"))"
        return code

    // 33: Radio
    if k == 33:
        let mut icon: string = "circle"
        if w.is_checked:
            icon = "largecircle.fill.circle"
        let mut code: string = ind + "HStack(spacing: 8) {\n"
        code = code + ind + "    Image(systemName: \"" + icon + "\")\n"
        code = code + ind + "        .foregroundColor(Color(hex: \"" + w.color + "\"))\n"
        code = code + ind + "    Text(\"" + w.text + "\")\n"
        code = code + ind + "        .foregroundColor(Color(hex: \"#e6edf3\"))\n"
        code = code + ind + "}"
        return code

    // 34: Chip
    if k == 34:
        let mut code: string = ind + "HStack(spacing: 6) {\n"
        if len(w.icon_name) > 0:
            code = code + ind + "    Image(systemName: \"" + w.icon_name + "\")\n"
        code = code + ind + "    Text(\"" + w.text + "\")\n"
        code = code + ind + "        .font(.system(size: 13, weight: .medium))\n"
        code = code + ind + "}\n"
        code = code + ind + ".padding(.horizontal, 12)\n"
        code = code + ind + ".padding(.vertical, 6)\n"
        code = code + ind + ".background(Capsule().fill(Color(hex: \"" + w.bg_color + "\")))\n"
        code = code + ind + ".foregroundColor(Color(hex: \"" + w.color + "\"))"
        return code

    // 35: CircularProgressIndicator
    if k == 35:
        let mut code: string = ind + "ProgressView()\n"
        code = code + ind + "    .progressViewStyle(CircularProgressViewStyle(tint: Color(hex: \"" + w.color + "\")))\n"
        code = code + ind + "    .scaleEffect(" + str(w.width) + ".0 / 32.0)"
        return code

    // 36: Drawer
    if k == 36:
        let mut code: string = ind + "NavigationSplitView {\n"
        code = code + ind + "    List {\n"
        let mut di: int = 0
        while di < len(w.children):
            code = code + render_widget_to_swiftui(w.children[di], depth + 2) + "\n"
            di = di + 1
        code = code + ind + "    }\n"
        code = code + ind + "} detail: { Text(\"Detail\") }"
        return code

    // 37: BottomSheet
    if k == 37:
        let mut op_val: string = "false"
        if w.is_checked:
            op_val = "true"
        let mut code: string = ind + ".sheet(isPresented: .constant(" + op_val + ")) {\n"
        if len(w.children) > 0:
            code = code + render_widget_to_swiftui(w.children[0], depth + 1) + "\n"
        code = code + ind + "}"
        return code

    // 38: ExpansionTile / Accordion
    if k == 38:
        let mut code: string = ind + "DisclosureGroup(\"" + w.text + "\") {\n"
        let mut ei: int = 0
        while ei < len(w.children):
            code = code + render_widget_to_swiftui(w.children[ei], depth + 1) + "\n"
            ei = ei + 1
        code = code + ind + "}\n"
        code = code + ind + ".padding()\n"
        code = code + ind + ".background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + ".cornerRadius(8)"
        return code

    // 39: Alert
    if k == 39:
        let mut code: string = ind + "VStack(alignment: .leading, spacing: 4) {\n"
        code = code + ind + "    Text(\"" + w.text + "\")\n"
        code = code + ind + "        .fontWeight(.bold)\n"
        code = code + ind + "        .foregroundColor(Color(hex: \"" + w.color + "\"))\n"
        if len(w.subtitle) > 0:
            code = code + ind + "    Text(\"" + w.subtitle + "\")\n"
            code = code + ind + "        .font(.system(size: 13))\n"
            code = code + ind + "        .foregroundColor(Color(hex: \"#e6edf3\"))\n"
        code = code + ind + "}\n"
        code = code + ind + ".padding(12)\n"
        code = code + ind + ".background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + ".cornerRadius(8)"
        return code

    // 40: Icon
    if k == 40:
        let mut code: string = ind + "Image(systemName: \"" + w.icon_name + "\")\n"
        code = code + ind + "    .font(.system(size: " + str(w.font_size) + "))\n"
        code = code + ind + "    .foregroundColor(Color(hex: \"" + w.color + "\"))"
        return code

    // 41: Stepper
    if k == 41:
        let mut code: string = ind + "Stepper(value: .constant(" + str(w.value) + "), in: " + str(w.min_value) + "..." + str(w.max_value) + ") {\n"
        code = code + ind + "    Text(\"" + w.text + "\")\n"
        code = code + ind + "        .foregroundColor(Color(hex: \"#e6edf3\"))\n"
        code = code + ind + "}\n"
        code = code + ind + ".accentColor(Color(hex: \"" + w.color + "\"))"
        return code

    // 42: SegmentedButton
    if k == 42:
        let mut code: string = ind + "Picker(\"\", selection: .constant(" + str(w.active_index) + ")) {\n"
        let mut sgi: int = 0
        while sgi < len(w.options):
            code = code + ind + "    Text(\"" + w.options[sgi] + "\").tag(" + str(sgi) + ")\n"
            sgi = sgi + 1
        code = code + ind + "}\n"
        code = code + ind + ".pickerStyle(.segmented)"
        return code

    // 43: Tooltip
    if k == 43:
        let mut code: string = ""
        if len(w.children) > 0:
            code = render_widget_to_swiftui(w.children[0], depth) + "\n"
        code = code + ind + ".help(\"" + w.text + "\")"
        return code

    // 44: NavigationRail
    if k == 44:
        let mut code: string = ind + "NavigationSplitView {\n"
        code = code + ind + "    List(selection: .constant(" + str(w.active_index) + ")) {\n"
        let mut nri: int = 0
        while nri < len(w.children):
            code = code + render_widget_to_swiftui(w.children[nri], depth + 2) + "\n"
            nri = nri + 1
        code = code + ind + "    }\n"
        code = code + ind + "    .navigationSplitViewColumnWidth(" + str(w.width) + ")\n"
        code = code + ind + "} detail: { Text(\"Select an item\") }"
        return code

    // 45: DataTable
    if k == 45:
        let mut code: string = ind + "VStack(spacing: 0) {\n"
        code = code + ind + "    HStack {\n"
        let mut thi: int = 0
        while thi < len(w.options):
            code = code + ind + "        Text(\"" + w.options[thi] + "\").font(.headline).foregroundColor(Color(hex: \"#8b949e\")).frame(maxWidth: .infinity, alignment: .leading)\n"
            thi = thi + 1
        code = code + ind + "    }.padding(10).background(Color(hex: \"#21262d\"))\n"
        code = code + ind + "    Divider()\n"
        let mut dri: int = 0
        while dri < len(w.children):
            code = code + render_widget_to_swiftui(w.children[dri], depth + 1) + "\n"
            dri = dri + 1
        code = code + ind + "}\n"
        code = code + ind + ".background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + ".cornerRadius(8)"
        return code

    // 46: Rating
    if k == 46:
        let mut code: string = ind + "HStack(spacing: 3) {\n"
        code = code + ind + "    ForEach(1..." + str(w.max_value) + ", id: \\.self) { index in\n"
        code = code + ind + "        Image(systemName: index <= " + str(w.value) + " ? \"star.fill\" : \"star\")\n"
        code = code + ind + "            .font(.system(size: " + str(w.font_size) + "))\n"
        code = code + ind + "            .foregroundColor(Color(hex: \"" + w.color + "\"))\n"
        code = code + ind + "    }\n"
        code = code + ind + "}"
        return code

    // 47: Skeleton
    if k == 47:
        let mut code: string = ind + "RoundedRectangle(cornerRadius: " + str(w.border_radius) + ")\n"
        code = code + ind + "    .fill(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + "    .frame(width: " + str(w.width) + ", height: " + str(w.height) + ")\n"
        code = code + ind + "    .redacted(reason: .placeholder)"
        return code

    // 48: Breadcrumbs
    if k == 48:
        let mut code: string = ind + "HStack(spacing: 4) {\n"
        let mut bci: int = 0
        while bci < len(w.options):
            if bci > 0:
                code = code + ind + "    Text(\"/\").foregroundColor(Color(hex: \"#484f58\"))\n"
            code = code + ind + "    Text(\"" + w.options[bci] + "\").foregroundColor(Color(hex: \"" + w.color + "\"))\n"
            bci = bci + 1
        code = code + ind + "}"
        return code

    // 49: CodeBlock
    if k == 49:
        let mut code: string = ind + "VStack(alignment: .leading, spacing: 0) {\n"
        code = code + ind + "    HStack {\n"
        code = code + ind + "        Text(\"" + w.value_str + "\").font(.caption).foregroundColor(Color(hex: \"#8b949e\"))\n"
        code = code + ind + "        Spacer()\n"
        code = code + ind + "        Image(systemName: \"doc.on.doc\").font(.caption).foregroundColor(Color(hex: \"#8b949e\"))\n"
        code = code + ind + "    }.padding(8).background(Color(hex: \"#161b22\"))\n"
        code = code + ind + "    ScrollView(.horizontal) {\n"
        code = code + ind + "        Text(\"" + w.text + "\")\n"
        code = code + ind + "            .font(.system(.body, design: .monospaced))\n"
        code = code + ind + "            .foregroundColor(Color(hex: \"" + w.color + "\"))\n"
        code = code + ind + "            .padding(" + str(w.padding) + ")\n"
        code = code + ind + "    }\n"
        code = code + ind + "}\n"
        code = code + ind + ".background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + ".cornerRadius(" + str(w.border_radius) + ")"
        return code

    // 50: MetricCard
    if k == 50:
        let mut code: string = ind + "VStack(alignment: .leading, spacing: 8) {\n"
        code = code + ind + "    HStack {\n"
        code = code + ind + "        Text(\"" + w.text + "\").font(.caption).foregroundColor(Color(hex: \"#8b949e\"))\n"
        code = code + ind + "        Spacer()\n"
        code = code + ind + "        Image(systemName: \"" + w.icon_name + "\").foregroundColor(Color(hex: \"" + w.color + "\"))\n"
        code = code + ind + "    }\n"
        code = code + ind + "    Text(\"" + w.value_str + "\").font(.title).fontWeight(.bold).foregroundColor(Color(hex: \"#e6edf3\"))\n"
        if len(w.subtitle) > 0:
            let mut col: string = "#f85149"
            let mut arr: string = "arrow.down"
            if w.is_checked:
                col = "#3fb950"
                arr = "arrow.up"
            code = code + ind + "    HStack(spacing: 4) {\n"
            code = code + ind + "        Image(systemName: \"" + arr + "\").font(.caption).foregroundColor(Color(hex: \"" + col + "\"))\n"
            code = code + ind + "        Text(\"" + w.subtitle + "\").font(.caption).foregroundColor(Color(hex: \"" + col + "\"))\n"
            code = code + ind + "    }\n"
        code = code + ind + "}\n"
        code = code + ind + ".padding(" + str(w.padding) + ")\n"
        code = code + ind + ".background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + ".cornerRadius(" + str(w.border_radius) + ")"
        return code

    // 51: CupertinoButton (Apple iOS)
    if k == 51:
        let mut code: string = ind + "Button(action: { /* " + w.on_click + " */ }) {\n"
        code = code + ind + "    Text(\"" + w.text + "\")\n"
        code = code + ind + "        .font(.system(size: " + str(w.font_size) + ", weight: .semibold))\n"
        code = code + ind + "        .padding(.horizontal, 20)\n"
        code = code + ind + "        .padding(.vertical, " + str(w.padding) + ")\n"
        if w.is_checked:
            code = code + ind + "        .background(Color(hex: \"" + w.bg_color + "\"))\n"
            code = code + ind + "        .foregroundColor(.white)\n"
        else:
            code = code + ind + "        .foregroundColor(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + "        .cornerRadius(" + str(w.border_radius) + ")\n"
        code = code + ind + "}"
        return code

    // 52: CupertinoNavigationBar (Apple iOS Frosted Glass)
    if k == 52:
        let mut code: string = ind + "HStack {\n"
        if len(w.children) > 0:
            code = code + render_widget_to_swiftui(w.children[0], depth + 1) + "\n"
        code = code + ind + "    Spacer()\n"
        code = code + ind + "    Text(\"" + w.text + "\").font(.headline).fontWeight(.semibold)\n"
        code = code + ind + "    Spacer()\n"
        if len(w.children) > 1:
            code = code + render_widget_to_swiftui(w.children[1], depth + 1) + "\n"
        code = code + ind + "}\n"
        code = code + ind + ".padding(.horizontal, 16)\n"
        code = code + ind + ".padding(.vertical, 12)\n"
        code = code + ind + ".background(.ultraThinMaterial)"
        return code

    // 53: CupertinoTabBar (Apple iOS Tab Bar)
    if k == 53:
        let mut code: string = ind + "TabView(selection: $selectedTab) {\n"
        let mut tb_i: int = 0
        while tb_i < len(w.children):
            code = code + render_widget_to_swiftui(w.children[tb_i], depth + 1) + "\n"
            tb_i = tb_i + 1
        code = code + ind + "}"
        return code

    // 54: CupertinoActionSheet (Apple iOS Action Sheet)
    if k == 54:
        let mut code: string = ind + "VStack(spacing: 8) {\n"
        code = code + ind + "    VStack(spacing: 4) {\n"
        code = code + ind + "        Text(\"" + w.text + "\").font(.footnote).fontWeight(.bold).foregroundColor(.secondary)\n"
        code = code + ind + "        Text(\"" + w.subtitle + "\").font(.caption).foregroundColor(.secondary)\n"
        code = code + ind + "    }\n"
        code = code + ind + "    .padding(14)\n"
        let mut as_i: int = 0
        while as_i < len(w.children):
            code = code + render_widget_to_swiftui(w.children[as_i], depth + 1) + "\n"
            as_i = as_i + 1
        code = code + ind + "    Button(\"" + w.value_str + "\", role: .cancel) {}\n"
        code = code + ind + "        .font(.headline)\n"
        code = code + ind + "}\n"
        code = code + ind + ".padding(16)\n"
        code = code + ind + ".background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + ".cornerRadius(" + str(w.border_radius) + ")"
        return code

    // 55: CupertinoSwitch (Apple iOS Fluid Toggle)
    if k == 55:
        return ind + "Toggle(\"\", isOn: $toggleState)\n" + ind + "    .toggleStyle(SwitchToggleStyle(tint: Color.green))"

    // 56: CupertinoPicker (Apple iOS Wheel Picker)
    if k == 56:
        let mut code: string = ind + "Picker(\"\", selection: $selectedItem) {\n"
        let mut p_i: int = 0
        while p_i < len(w.options):
            code = code + ind + "    Text(\"" + w.options[p_i] + "\").tag(" + str(p_i) + ")\n"
            p_i = p_i + 1
        code = code + ind + "}\n" + ind + ".pickerStyle(.wheel)"
        return code

    // 57: CupertinoSegmentedControl (Apple iOS Pill Segment)
    if k == 57:
        let mut code: string = ind + "Picker(\"\", selection: $selectedSegment) {\n"
        let mut sc_i: int = 0
        while sc_i < len(w.options):
            code = code + ind + "    Text(\"" + w.options[sc_i] + "\").tag(" + str(sc_i) + ")\n"
            sc_i = sc_i + 1
        code = code + ind + "}\n" + ind + ".pickerStyle(.segmented)"
        return code

    // 58: FilledButton (Flutter Material 3)
    if k == 58:
        let mut code: string = ind + "Button(action: { /* " + w.on_click + " */ }) {\n"
        code = code + ind + "    Text(\"" + w.text + "\")\n"
        code = code + ind + "        .fontWeight(.semibold)\n"
        code = code + ind + "        .padding(.horizontal, 24)\n"
        code = code + ind + "        .padding(.vertical, " + str(w.padding) + ")\n"
        code = code + ind + "        .background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + "        .foregroundColor(Color(hex: \"" + w.color + "\"))\n"
        code = code + ind + "        .cornerRadius(" + str(w.border_radius) + ")\n"
        code = code + ind + "}"
        return code

    // 59: OutlinedButton (Flutter Material 3)
    if k == 59:
        let mut code: string = ind + "Button(action: { /* " + w.on_click + " */ }) {\n"
        code = code + ind + "    Text(\"" + w.text + "\")\n"
        code = code + ind + "        .fontWeight(.semibold)\n"
        code = code + ind + "        .padding(.horizontal, 24)\n"
        code = code + ind + "        .padding(.vertical, " + str(w.padding) + ")\n"
        code = code + ind + "        .foregroundColor(Color(hex: \"" + w.color + "\"))\n"
        code = code + ind + "        .overlay(RoundedRectangle(cornerRadius: " + str(w.border_radius) + ").stroke(Color(hex: \"" + w.border_color + "\"), lineWidth: 1))\n"
        code = code + ind + "}"
        return code

    // 60: TextButton (Flutter Material 3)
    if k == 60:
        return ind + "Button(\"" + w.text + "\", action: { /* " + w.on_click + " */ })\n" + ind + "    .foregroundColor(Color(hex: \"" + w.color + "\"))"

    // 61: FabExtended (Flutter Material 3 Extended FAB)
    if k == 61:
        let mut code: string = ind + "Button(action: { /* " + w.on_click + " */ }) {\n"
        code = code + ind + "    Label(\"" + w.text + "\", systemImage: \"" + w.icon_name + "\")\n"
        code = code + ind + "        .font(.headline)\n"
        code = code + ind + "        .padding(.horizontal, 20)\n"
        code = code + ind + "        .padding(.vertical, 16)\n"
        code = code + ind + "        .background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + "        .foregroundColor(Color(hex: \"" + w.color + "\"))\n"
        code = code + ind + "        .cornerRadius(" + str(w.border_radius) + ")\n"
        code = code + ind + "        .shadow(radius: 4)\n"
        code = code + ind + "}"
        return code

    // 62: SearchBar (Flutter Material 3 Search Bar)
    if k == 62:
        let mut code: string = ind + "HStack(spacing: 12) {\n"
        code = code + ind + "    Image(systemName: \"magnifyingglass\").foregroundColor(.secondary)\n"
        code = code + ind + "    TextField(\"" + w.placeholder + "\", text: $searchText)\n"
        code = code + ind + "}\n"
        code = code + ind + ".padding(.horizontal, 16)\n"
        code = code + ind + ".frame(height: " + str(w.height) + ")\n"
        code = code + ind + ".background(Color(hex: \"" + w.bg_color + "\"))\n"
        code = code + ind + ".cornerRadius(" + str(w.border_radius) + ")"
        return code

    // 63: FilterChip (Flutter Material 3 Filter Chip)
    if k == 63:
        let mut code: string = ind + "Toggle(isOn: $chipSelected) {\n"
        code = code + ind + "    Text(\"" + w.text + "\")\n"
        code = code + ind + "}\n"
        code = code + ind + ".toggleStyle(.button)\n"
        code = code + ind + ".tint(Color(hex: \"" + w.bg_color + "\"))"
        return code

    // 64: NavigationDrawer (Flutter Material 3 Navigation Drawer)
    if k == 64:
        let mut code: string = ind + "NavigationSplitView {\n"
        let mut nd_i: int = 0
        while nd_i < len(w.children):
            code = code + render_widget_to_swiftui(w.children[nd_i], depth + 1) + "\n"
            nd_i = nd_i + 1
        code = code + ind + "} detail: { Text(\"Select an item\") }"
        return code

    // 65: Form (SwiftUI Form)
    if k == 65:
        let mut code: string = ind + "Form {\n"
        let mut f_i: int = 0
        while f_i < len(w.children):
            code = code + render_widget_to_swiftui(w.children[f_i], depth + 1) + "\n"
            f_i = f_i + 1
        code = code + ind + "}"
        return code

    // 66: Section (SwiftUI Section)
    if k == 66:
        let mut code: string = ind + "Section(header: Text(\"" + w.text + "\")"
        if len(w.subtitle) > 0:
            code = code + ", footer: Text(\"" + w.subtitle + "\")"
        code = code + ") {\n"
        let mut s_i: int = 0
        while s_i < len(w.children):
            code = code + render_widget_to_swiftui(w.children[s_i], depth + 1) + "\n"
            s_i = s_i + 1
        code = code + ind + "}"
        return code

    // 67: List (SwiftUI List)
    if k == 67:
        let mut code: string = ind + "List {\n"
        let mut l_i: int = 0
        while l_i < len(w.children):
            code = code + render_widget_to_swiftui(w.children[l_i], depth + 1) + "\n"
            l_i = l_i + 1
        code = code + ind + "}"
        return code

    // 68: NavigationStack (SwiftUI NavigationStack)
    if k == 68:
        let mut code: string = ind + "NavigationStack {\n"
        if len(w.children) > 0:
            code = code + render_widget_to_swiftui(w.children[0], depth + 1) + "\n"
        code = code + ind + "}\n"
        if len(w.text) > 0:
            code = code + ind + ".navigationTitle(\"" + w.text + "\")"
        return code

    // 69: NavigationLink (SwiftUI NavigationLink)
    if k == 69:
        let mut code: string = ind + "NavigationLink(destination: Text(\"" + w.url + "\")) {\n"
        if len(w.children) > 0:
            code = code + render_widget_to_swiftui(w.children[0], depth + 1) + "\n"
        code = code + ind + "}"
        return code

    // 70: Gauge (SwiftUI Gauge)
    if k == 70:
        return ind + "Gauge(value: " + str(w.value) + ".0, in: " + str(w.min_value) + ".0..." + str(w.max_value) + ".0) {\n" + ind + "    Text(\"" + w.text + "\")\n" + ind + "}\n" + ind + ".tint(Color(hex: \"" + w.color + "\"))"

    // 99: RawHtml / Custom Component
    if k == 99:
        return ind + "// Custom: " + w.text

fn render_swiftui_view(view_name: string, root_widget: Widget) -> string:
    let mut code: string = "// Generated by Cluster UI Compiler\n"
    code = code + "import SwiftUI\n\n"
    code = code + "struct " + view_name + ": View {\n"
    code = code + "    @State private var inputText: String = \"\"\n"
    code = code + "    @State private var toggleState: Bool = false\n\n"
    code = code + "    var body: some View {\n"
    code = code + render_widget_to_swiftui(root_widget, 2) + "\n"
    code = code + "    }\n"
    code = code + "}\n"
    return code
