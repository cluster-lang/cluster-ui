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

    return ind + "// Unsupported widget: " + str(k)

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
