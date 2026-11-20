// ==============================================================================
// Cluster UI: Web / HTML5 Canvas Renderer
// Compiles Cluster UI Declarative Widget Tree directly into semantic HTML5 / Modern CSS
// 100% Zero JavaScript, Zero node_modules, Pure Cluster
// ==============================================================================

import src/core/widget.cl

fn render_widget_to_html(w: Widget) -> string:
    let k: int = w.kind

    // 1: Text
    if k == 1:
        let mut style: string = "font-size: " + str(w.font_size) + "px; color: " + w.color + ";"
        if w.bold:
            style = style + " font-weight: 600;"
        return "<span style=\"" + style + "\">" + w.text + "</span>"

    // 2: Button
    if k == 2:
        let mut btn_style: string = "background-color: " + w.bg_color + "; color: " + w.color + "; padding: " + str(w.padding) + "px 16px; border-radius: " + str(w.border_radius) + "px; font-size: " + str(w.font_size) + "px; border: none; cursor: pointer; font-weight: 600; transition: transform 0.1s;"
        let mut click_attr: string = ""
        if len(w.on_click) > 0:
            click_attr = " onclick=\"" + w.on_click + "\""
        return "<button style=\"" + btn_style + "\"" + click_attr + ">" + w.text + "</button>"

    // 3: Column (Vertical Flex Stack — Flutter Column / SwiftUI VStack)
    if k == 3:
        let col_style: string = "display: flex; flex-direction: column; gap: " + str(w.spacing) + "px; padding: " + str(w.padding) + "px;"
        let mut children_html: string = ""
        let mut i: int = 0
        while i < len(w.children):
            let ch_w: Widget = w.children[i]
            children_html = children_html + render_widget_to_html(ch_w)
            i = i + 1
        return "<div style=\"" + col_style + "\">" + children_html + "</div>"

    // 4: Row (Horizontal Flex Stack — Flutter Row / SwiftUI HStack)
    if k == 4:
        let row_style: string = "display: flex; flex-direction: row; align-items: center; gap: " + str(w.spacing) + "px; padding: " + str(w.padding) + "px;"
        let mut r_children_html: string = ""
        let mut j: int = 0
        while j < len(w.children):
            let r_ch: Widget = w.children[j]
            r_children_html = r_children_html + render_widget_to_html(r_ch)
            j = j + 1
        return "<div style=\"" + row_style + "\">" + r_children_html + "</div>"

    // 5: Box (Container / Frame — Flutter Container / SwiftUI Frame)
    if k == 5:
        let mut box_style: string = "box-sizing: border-box;"
        if len(w.bg_color) > 0:
            box_style = box_style + " background-color: " + w.bg_color + ";"
        if w.padding > 0:
            box_style = box_style + " padding: " + str(w.padding) + "px;"
        if w.border_radius > 0:
            box_style = box_style + " border-radius: " + str(w.border_radius) + "px;"
        if w.width > 0:
            box_style = box_style + " width: " + str(w.width) + "px;"
        if w.height > 0:
            box_style = box_style + " height: " + str(w.height) + "px;"

        let mut b_children_html: string = ""
        let mut bi: int = 0
        while bi < len(w.children):
            let b_ch: Widget = w.children[bi]
            b_children_html = b_children_html + render_widget_to_html(b_ch)
            bi = bi + 1
        return "<div style=\"" + box_style + "\">" + b_children_html + "</div>"

    // 6: Spacer
    if k == 6:
        return "<div style=\"flex: 1;\"></div>"

    // 7: TextInput
    if k == 7:
        let input_style: string = "background-color: " + w.bg_color + "; color: " + w.color + "; padding: " + str(w.padding) + "px 12px; border-radius: " + str(w.border_radius) + "px; border: " + str(w.border_width) + "px solid " + w.border_color + "; font-size: " + str(w.font_size) + "px; outline: none;"
        return "<input type=\"text\" placeholder=\"" + w.placeholder + "\" style=\"" + input_style + "\" />"

    return ""

fn render_page_html(title: string, root_widget: Widget) -> string:
    let mut doc: string = "<!DOCTYPE html>\n<html>\n<head>\n"
    doc = doc + "    <meta charset=\"utf-8\">\n"
    doc = doc + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
    doc = doc + "    <title>" + title + "</title>\n"
    doc = doc + "    <style>\n"
    doc = doc + "        * { box-sizing: border-box; margin: 0; padding: 0; }\n"
    doc = doc + "        body { background-color: #0d1117; color: #e6edf3; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 20px; }\n"
    doc = doc + "    </style>\n"
    doc = doc + "</head>\n<body>\n"
    doc = doc + render_widget_to_html(root_widget) + "\n"
    doc = doc + "</body>\n</html>"
    return doc
