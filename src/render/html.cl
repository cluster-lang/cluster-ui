// ==============================================================================
// Cluster UI: Web / HTML5 Modern Flex & Grid Renderer
// Compiles Cluster UI Declarative Widget Tree directly into semantic HTML5 & Modern CSS
// 100% Zero Dependencies, Zero External Frameworks, Pure Native Cluster
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
        let mut btn_style: string = "background-color: " + w.bg_color + "; color: " + w.color + "; padding: " + str(w.padding) + "px 16px; border-radius: " + str(w.border_radius) + "px; font-size: " + str(w.font_size) + "px; border: none; cursor: pointer; font-weight: 600; transition: all 0.15s ease;"
        let mut click_attr: string = ""
        if len(w.on_click) > 0:
            click_attr = " onclick=\"" + w.on_click + "\""
        return "<button style=\"" + btn_style + "\"" + click_attr + ">" + w.text + "</button>"

    // 3: Column / VStack
    if k == 3:
        let col_style: string = "display: flex; flex-direction: column; gap: " + str(w.spacing) + "px; padding: " + str(w.padding) + "px; box-sizing: border-box;"
        let mut children_html: string = ""
        let mut i: int = 0
        while i < len(w.children):
            children_html = children_html + render_widget_to_html(w.children[i])
            i = i + 1
        return "<div style=\"" + col_style + "\">" + children_html + "</div>"

    // 4: Row / HStack
    if k == 4:
        let row_style: string = "display: flex; flex-direction: row; align-items: center; gap: " + str(w.spacing) + "px; padding: " + str(w.padding) + "px; box-sizing: border-box;"
        let mut r_children_html: string = ""
        let mut j: int = 0
        while j < len(w.children):
            r_children_html = r_children_html + render_widget_to_html(w.children[j])
            j = j + 1
        return "<div style=\"" + row_style + "\">" + r_children_html + "</div>"

    // 5: Box / Container
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
            b_children_html = b_children_html + render_widget_to_html(w.children[bi])
            bi = bi + 1
        return "<div style=\"" + box_style + "\">" + b_children_html + "</div>"

    // 6: Spacer
    if k == 6:
        return "<div style=\"flex: 1;\"></div>"

    // 7: TextInput
    if k == 7:
        let input_style: string = "background-color: " + w.bg_color + "; color: " + w.color + "; padding: " + str(w.padding) + "px 12px; border-radius: " + str(w.border_radius) + "px; border: " + str(w.border_width) + "px solid " + w.border_color + "; font-size: " + str(w.font_size) + "px; outline: none; width: 100%; box-sizing: border-box;"
        return "<input type=\"text\" placeholder=\"" + w.placeholder + "\" style=\"" + input_style + "\" />"

    // 8: Image
    if k == 8:
        let mut img_style: string = "object-fit: cover;"
        if w.width > 0:
            img_style = img_style + " width: " + str(w.width) + "px;"
        if w.height > 0:
            img_style = img_style + " height: " + str(w.height) + "px;"
        if w.border_radius > 0:
            img_style = img_style + " border-radius: " + str(w.border_radius) + "px;"
        return "<img src=\"" + w.image_url + "\" alt=\"" + w.text + "\" style=\"" + img_style + "\" />"

    // 9: ZStack / Stack
    if k == 9:
        let mut stack_style: string = "display: grid; position: relative; box-sizing: border-box;"
        if w.align == "center":
            stack_style = stack_style + " place-items: center;"
        let mut stack_ch_html: string = ""
        let mut si: int = 0
        while si < len(w.children):
            stack_ch_html = stack_ch_html + "<div style=\"grid-area: 1/1;\">" + render_widget_to_html(w.children[si]) + "</div>"
            si = si + 1
        return "<div style=\"" + stack_style + "\">" + stack_ch_html + "</div>"

    // 10: Divider
    if k == 10:
        return "<hr style=\"border: none; height: " + str(w.height) + "px; background-color: " + w.bg_color + "; margin: 8px 0; width: 100%;\" />"

    // 11: Card
    if k == 11:
        let card_style: string = "box-sizing: border-box; background-color: " + w.bg_color + "; border-radius: " + str(w.border_radius) + "px; padding: " + str(w.padding) + "px; box-shadow: 0 4px 14px rgba(0,0,0,0.35); border: 1px solid #30363d;"
        let mut card_ch: string = ""
        let mut ci: int = 0
        while ci < len(w.children):
            card_ch = card_ch + render_widget_to_html(w.children[ci])
            ci = ci + 1
        return "<div style=\"" + card_style + "\">" + card_ch + "</div>"

    // 12: Badge / Chip
    if k == 12:
        let badge_style: string = "display: inline-flex; align-items: center; background-color: " + w.bg_color + "; color: " + w.color + "; font-size: " + str(w.font_size) + "px; font-weight: 600; padding: " + str(w.padding) + "px 10px; border-radius: " + str(w.border_radius) + "px;"
        return "<span style=\"" + badge_style + "\">" + w.text + "</span>"

    // 13: Toggle / Switch
    if k == 13:
        let mut chk_attr: string = ""
        if w.is_checked:
            chk_attr = " checked"
        let mut sw_click: string = ""
        if len(w.on_click) > 0:
            sw_click = " onclick=\"" + w.on_click + "\""
        let mut label_part: string = ""
        if len(w.text) > 0:
            label_part = "<span style=\"color: #e6edf3; font-size: 14px;\">" + w.text + "</span>"
        return "<label style=\"display: inline-flex; align-items: center; gap: 10px; cursor: pointer;\"><input type=\"checkbox\"" + chk_attr + sw_click + " style=\"width: 18px; height: 18px; accent-color: #238636; cursor: pointer;\" />" + label_part + "</label>"

    // 14: ProgressBar
    if k == 14:
        let track_style: string = "width: 100%; background-color: " + w.bg_color + "; height: " + str(w.height) + "px; border-radius: " + str(w.border_radius) + "px; overflow: hidden;"
        let bar_style: string = "width: " + str(w.value) + "%; background-color: " + w.color + "; height: 100%; border-radius: " + str(w.border_radius) + "px; transition: width 0.3s ease;"
        return "<div style=\"" + track_style + "\"><div style=\"" + bar_style + "\"></div></div>"

    // 15: ListTile
    if k == 15:
        let tile_style: string = "display: flex; flex-direction: row; align-items: center; justify-content: space-between; padding: 10px 14px; border-radius: 8px; cursor: pointer; transition: background 0.15s ease;"
        let mut click_attr: string = ""
        if len(w.on_click) > 0:
            click_attr = " onclick=\"" + w.on_click + "\""
        let mut icon_part: string = ""
        if len(w.icon_name) > 0:
            icon_part = "<span style=\"font-size: 18px; margin-right: 12px;\">" + w.icon_name + "</span>"
        let mut sub_part: string = ""
        if len(w.subtitle) > 0:
            sub_part = "<span style=\"font-size: 12px; color: #8b949e;\">" + w.subtitle + "</span>"
        let text_col: string = "<div style=\"display: flex; flex-direction: column; gap: 2px;\"><span style=\"font-size: 14px; color: #e6edf3; font-weight: 500;\">" + w.text + "</span>" + sub_part + "</div>"
        let chevron: string = "<span style=\"color: #8b949e; font-size: 16px;\">›</span>"
        return "<div style=\"" + tile_style + "\"" + click_attr + "><div style=\"display: flex; align-items: center;\">" + icon_part + text_col + "</div>" + chevron + "</div>"

    // 16: Center
    if k == 16:
        let center_style: string = "display: flex; justify-content: center; align-items: center; width: 100%; height: 100%; box-sizing: border-box;"
        let mut center_ch: string = ""
        let mut cti: int = 0
        while cti < len(w.children):
            center_ch = center_ch + render_widget_to_html(w.children[cti])
            cti = cti + 1
        return "<div style=\"" + center_style + "\">" + center_ch + "</div>"

    // 17: Link
    if k == 17:
        let link_style: string = "color: " + w.color + "; font-size: " + str(w.font_size) + "px; text-decoration: none;"
        return "<a href=\"" + w.url + "\" style=\"" + link_style + "\">" + w.text + "</a>"

    // 18: Expanded
    if k == 18:
        let exp_style: string = "flex: " + str(w.flex) + "; min-width: 0;"
        let mut exp_ch: string = ""
        let mut ei: int = 0
        while ei < len(w.children):
            exp_ch = exp_ch + render_widget_to_html(w.children[ei])
            ei = ei + 1
        return "<div style=\"" + exp_style + "\">" + exp_ch + "</div>"

    // 19: AppBar
    if k == 19:
        let bar_style: string = "display: flex; flex-direction: row; align-items: center; justify-content: space-between; background-color: " + w.bg_color + "; padding: 12px 20px; border-bottom: 1px solid #30363d; width: 100%; box-sizing: border-box;"
        let mut lead_html: string = ""
        let mut trail_html: string = ""
        if len(w.children) > 0:
            lead_html = render_widget_to_html(w.children[0])
        if len(w.children) > 1:
            trail_html = render_widget_to_html(w.children[1])
        let title_html: string = "<span style=\"font-size: 18px; font-weight: 600; color: #e6edf3;\">" + w.text + "</span>"
        return "<div style=\"" + bar_style + "\"><div style=\"display: flex; align-items: center; gap: 12px;\">" + lead_html + title_html + "</div>" + trail_html + "</div>"

    // 20: BottomNavigationBar
    if k == 20:
        let bbar_style: string = "display: flex; flex-direction: row; align-items: center; justify-content: space-around; background-color: " + w.bg_color + "; padding: 8px 12px; border-top: 1px solid #30363d; width: 100%; box-sizing: border-box;"
        let mut items_html: string = ""
        let mut ti: int = 0
        while ti < len(w.children):
            items_html = items_html + render_widget_to_html(w.children[ti])
            ti = ti + 1
        return "<div style=\"" + bbar_style + "\">" + items_html + "</div>"

    // 21: TabItem
    if k == 21:
        let mut tab_color: string = "#8b949e"
        if w.is_checked:
            tab_color = "#58a6ff"
        let tab_style: string = "display: flex; flex-direction: column; align-items: center; gap: 3px; cursor: pointer; color: " + tab_color + "; position: relative; padding: 4px 8px;"
        let icon_html: string = "<span style=\"font-size: 20px;\">" + w.icon_name + "</span>"
        let label_html: string = "<span style=\"font-size: 11px; font-weight: 500;\">" + w.text + "</span>"
        let mut badge_html: string = ""
        if w.badge_count > 0:
            badge_html = "<span style=\"position: absolute; top: 0; right: 2px; background-color: #f85149; color: #fff; font-size: 10px; font-weight: bold; border-radius: 8px; padding: 1px 5px;\">" + str(w.badge_count) + "</span>"
        return "<div style=\"" + tab_style + "\">" + icon_html + label_html + badge_html + "</div>"

    // 22: FloatingActionButton (FAB)
    if k == 22:
        let fab_style: string = "display: inline-flex; justify-content: center; align-items: center; width: " + str(w.width) + "px; height: " + str(w.height) + "px; border-radius: " + str(w.border_radius) + "px; background-color: " + w.bg_color + "; color: #ffffff; font-size: 24px; box-shadow: 0 6px 16px rgba(0,0,0,0.4); border: none; cursor: pointer; transition: transform 0.15s ease;"
        let mut click_attr: string = ""
        if len(w.on_click) > 0:
            click_attr = " onclick=\"" + w.on_click + "\""
        return "<button style=\"" + fab_style + "\"" + click_attr + ">" + w.icon_name + "</button>"

    // 23: Dialog / Modal
    if k == 23:
        let dialog_card_style: string = "box-sizing: border-box; background-color: " + w.bg_color + "; border-radius: 14px; padding: 20px; border: 1px solid #30363d; box-shadow: 0 16px 40px rgba(0,0,0,0.6); max-width: 400px; width: 100%; display: flex; flex-direction: column; gap: 14px;"
        let title_html: string = "<span style=\"font-size: 18px; font-weight: 600; color: #f0f6fc;\">" + w.text + "</span>"
        let mut content_html: string = ""
        let mut actions_html: string = ""
        if len(w.children) > 0:
            content_html = render_widget_to_html(w.children[0])
        let mut ai: int = 1
        while ai < len(w.children):
            actions_html = actions_html + render_widget_to_html(w.children[ai])
            ai = ai + 1
        let actions_bar: string = "<div style=\"display: flex; justify-content: flex-end; gap: 10px; margin-top: 8px;\">" + actions_html + "</div>"
        return "<div style=\"" + dialog_card_style + "\">" + title_html + content_html + actions_bar + "</div>"

    // 24: SnackBar / Toast
    if k == 24:
        let snack_style: string = "display: flex; flex-direction: row; align-items: center; justify-content: space-between; background-color: " + w.bg_color + "; color: #f0f6fc; padding: 12px 16px; border-radius: 8px; border: 1px solid #30363d; box-shadow: 0 4px 16px rgba(0,0,0,0.4); font-size: 13px;"
        let mut act_html: string = ""
        if len(w.subtitle) > 0:
            let mut clk: string = ""
            if len(w.on_click) > 0:
                clk = " onclick=\"" + w.on_click + "\""
            act_html = "<span style=\"color: #58a6ff; font-weight: 600; cursor: pointer; margin-left: 16px;\"" + clk + ">" + w.subtitle + "</span>"
        return "<div style=\"" + snack_style + "\"><span>" + w.text + "</span>" + act_html + "</div>"

    // 25: Grid (Responsive Multi-Column)
    if k == 25:
        let grid_style: string = "display: grid; grid-template-columns: repeat(" + str(w.columns) + ", minmax(0, 1fr)); gap: " + str(w.spacing) + "px; width: 100%; box-sizing: border-box;"
        let mut grid_ch: string = ""
        let mut gi: int = 0
        while gi < len(w.children):
            grid_ch = grid_ch + render_widget_to_html(w.children[gi])
            gi = gi + 1
        return "<div style=\"" + grid_style + "\">" + grid_ch + "</div>"

    // 26: Wrap (Flow layout)
    if k == 26:
        let wrap_style: string = "display: flex; flex-wrap: wrap; gap: " + str(w.spacing) + "px; align-items: center; width: 100%; box-sizing: border-box;"
        let mut wrap_ch: string = ""
        let mut wi: int = 0
        while wi < len(w.children):
            wrap_ch = wrap_ch + render_widget_to_html(w.children[wi])
            wi = wi + 1
        return "<div style=\"" + wrap_style + "\">" + wrap_ch + "</div>"

    // 27: Avatar
    if k == 27:
        let av_container: string = "position: relative; display: inline-flex; width: " + str(w.width) + "px; height: " + str(w.height) + "px;"
        let av_style: string = "display: flex; justify-content: center; align-items: center; width: " + str(w.width) + "px; height: " + str(w.height) + "px; border-radius: " + str(w.border_radius) + "px; background-color: " + w.bg_color + "; color: #ffffff; font-weight: 600; font-size: " + str(w.width / 2) + "px; overflow: hidden;"
        let mut inner: string = w.text
        if len(w.image_url) > 0:
            inner = "<img src=\"" + w.image_url + "\" style=\"width: 100%; height: 100%; object-fit: cover;\" />"
        let mut dot: string = ""
        if w.is_online:
            dot = "<span style=\"position: absolute; bottom: 0; right: 0; width: 12px; height: 12px; background-color: #3fb950; border: 2px solid #161b22; border-radius: 50%;\"></span>"
        return "<div style=\"" + av_container + "\"><div style=\"" + av_style + "\">" + inner + "</div>" + dot + "</div>"

    // 28: Dropdown / Picker
    if k == 28:
        let sel_style: string = "background-color: " + w.bg_color + "; color: " + w.color + "; padding: 8px 12px; border-radius: " + str(w.border_radius) + "px; border: 1px solid #30363d; font-size: 14px; outline: none; cursor: pointer;"
        let mut click_attr: string = ""
        if len(w.on_click) > 0:
            click_attr = " onchange=\"" + w.on_click + "\""
        let mut opts_html: string = ""
        let mut oi: int = 0
        while oi < len(w.options):
            let mut sel_attr: string = ""
            if oi == w.active_index:
                sel_attr = " selected"
            opts_html = opts_html + "<option value=\"" + w.options[oi] + "\"" + sel_attr + ">" + w.options[oi] + "</option>"
            oi = oi + 1
        return "<select style=\"" + sel_style + "\"" + click_attr + ">" + opts_html + "</select>"

    // 29: Scaffold
    if k == 29:
        let sc_style: string = "position: relative; display: flex; flex-direction: column; width: 100%; min-height: 100vh; background-color: " + w.bg_color + "; box-sizing: border-box; overflow: hidden;"
        let mut app_bar_html: string = ""
        let mut body_html: string = ""
        let mut bbar_html: string = ""
        let mut fab_html: string = ""
        if len(w.children) > 0:
            app_bar_html = render_widget_to_html(w.children[0])
        if len(w.children) > 1:
            body_html = "<div style=\"flex: 1; overflow-y: auto; display: flex; flex-direction: column;\">" + render_widget_to_html(w.children[1]) + "</div>"
        if len(w.children) > 2:
            bbar_html = render_widget_to_html(w.children[2])
        if len(w.children) > 3:
            fab_html = "<div style=\"position: absolute; bottom: 80px; right: 24px; z-index: 99;\">" + render_widget_to_html(w.children[3]) + "</div>"
        return "<div style=\"" + sc_style + "\">" + app_bar_html + body_html + bbar_html + fab_html + "</div>"

    // 30: ScrollView
    if k == 30:
        let mut overflow_rule: string = "overflow-y: auto; overflow-x: hidden;"
        if w.is_checked:
            overflow_rule = "overflow-x: auto; overflow-y: hidden;"
        let sc_style: string = "width: 100%; height: 100%; " + overflow_rule + " box-sizing: border-box;"
        let mut child_html: string = ""
        if len(w.children) > 0:
            child_html = render_widget_to_html(w.children[0])
        return "<div style=\"" + sc_style + "\">" + child_html + "</div>"

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
