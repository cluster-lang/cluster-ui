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
        if w.is_animated:
            style = style + " transition: all " + str(w.anim_duration) + "ms " + w.anim_curve + "; will-change: transform, opacity;"
        let mut bind_attr: string = ""
        let mut display_text: string = w.text
        if len(w.bind_key) > 0:
            bind_attr = " data-bind=\"" + w.bind_key + "\""
        elif len(w.text) > 10:
            if substring(w.text, 0, 8) == "{{state:":
                let tlen: int = len(w.text)
                if substring(w.text, tlen - 2, 2) == "}}":
                    let bkey: string = substring(w.text, 8, tlen - 10)
                    bind_attr = " data-bind=\"" + bkey + "\""
                    display_text = "0"
        return "<span" + bind_attr + " style=\"" + style + "\">" + display_text + "</span>"

    // 2: Button
    if k == 2:
        let mut btn_style: string = "background-color: " + w.bg_color + "; color: " + w.color + "; padding: " + str(w.padding) + "px 16px; border-radius: " + str(w.border_radius) + "px; font-size: " + str(w.font_size) + "px; border: none; cursor: pointer; font-weight: 600;"
        if w.is_animated:
            btn_style = btn_style + " transition: all " + str(w.anim_duration) + "ms " + w.anim_curve + "; will-change: transform, box-shadow;"
        else:
            btn_style = btn_style + " transition: all 0.15s ease;"
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
        if w.width > 0 and w.width < 50000:
            box_style = box_style + " width: " + str(w.width) + "px; flex-shrink: 0;"
        if w.height > 0 and w.height < 50000:
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
        let mut card_style: string = "box-sizing: border-box; background-color: " + w.bg_color + "; border-radius: " + str(w.border_radius) + "px; padding: " + str(w.padding) + "px; box-shadow: 0 4px 14px rgba(0,0,0,0.35); border: 1px solid #30363d;"
        if w.is_animated:
            card_style = card_style + " transition: all " + str(w.anim_duration) + "ms " + w.anim_curve + "; will-change: transform, box-shadow;"
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

    // 31: Slider
    if k == 31:
        let mut ch_attr: string = ""
        if len(w.on_change) > 0:
            ch_attr = " oninput=\"" + w.on_change + "\""
        let sl_style: string = "width: 100%; accent-color: " + w.color + "; cursor: pointer; height: 6px; border-radius: 3px;"
        return "<input type=\"range\" min=\"" + str(w.min_value) + "\" max=\"" + str(w.max_value) + "\" value=\"" + str(w.value) + "\" style=\"" + sl_style + "\"" + ch_attr + " />"

    // 32: Checkbox
    if k == 32:
        let mut chk_attr: string = ""
        if w.is_checked:
            chk_attr = " checked"
        if len(w.on_click) > 0:
            chk_attr = chk_attr + " onclick=\"" + w.on_click + "\""
        let lbl_style: string = "display: inline-flex; align-items: center; gap: 8px; cursor: pointer; font-size: 14px; color: #e6edf3; user-select: none;"
        return "<label style=\"" + lbl_style + "\"><input type=\"checkbox\"" + chk_attr + " style=\"accent-color: " + w.color + "; width: 16px; height: 16px; cursor: pointer;\" /><span>" + w.text + "</span></label>"

    // 33: Radio
    if k == 33:
        let mut sel_attr: string = ""
        if w.is_checked:
            sel_attr = " checked"
        if len(w.on_click) > 0:
            sel_attr = sel_attr + " onclick=\"" + w.on_click + "\""
        let r_style: string = "display: inline-flex; align-items: center; gap: 8px; cursor: pointer; font-size: 14px; color: #e6edf3; user-select: none;"
        return "<label style=\"" + r_style + "\"><input type=\"radio\" value=\"" + w.value_str + "\"" + sel_attr + " style=\"accent-color: " + w.color + "; width: 16px; height: 16px; cursor: pointer;\" /><span>" + w.text + "</span></label>"

    // 34: Chip
    if k == 34:
        let chip_style: string = "display: inline-flex; align-items: center; gap: 6px; background-color: " + w.bg_color + "; color: " + w.color + "; padding: 4px 12px; border-radius: " + str(w.border_radius) + "px; font-size: 13px; font-weight: 500; border: 1px solid #30363d;"
        let mut del_btn: string = ""
        if len(w.on_delete) > 0:
            del_btn = "<span onclick=\"" + w.on_delete + "\" style=\"cursor: pointer; opacity: 0.7; font-weight: bold; margin-left: 4px;\">&times;</span>"
        return "<div style=\"" + chip_style + "\"><span>" + w.text + "</span>" + del_btn + "</div>"

    // 35: CircularProgressIndicator
    if k == 35:
        let sz: string = str(w.width) + "px"
        let sp_style: string = "display: inline-block; width: " + sz + "; height: " + sz + "; border: " + str(w.border_width) + "px solid rgba(255,255,255,0.15); border-top-color: " + w.color + "; border-radius: 50%; animation: cl_spin 0.8s linear infinite;"
        return "<div style=\"" + sp_style + "\"></div>"

    // 36: Drawer
    if k == 36:
        let dr_style: string = "width: 280px; min-height: 100vh; background-color: " + w.bg_color + "; border-right: 1px solid #30363d; display: flex; flex-direction: column; padding: 16px; gap: 12px; box-sizing: border-box;"
        let mut d_html: string = ""
        let mut di: int = 0
        while di < len(w.children):
            d_html = d_html + render_widget_to_html(w.children[di])
            di = di + 1
        return "<aside style=\"" + dr_style + "\">" + d_html + "</aside>"

    // 37: BottomSheet
    if k == 37:
        let bs_style: string = "position: fixed; bottom: 0; left: 0; right: 0; background-color: " + w.bg_color + "; border-top: 1px solid #30363d; border-radius: 16px 16px 0 0; padding: 24px; box-shadow: 0 -8px 24px rgba(0,0,0,0.5); z-index: 100;"
        let mut bs_html: string = ""
        if len(w.children) > 0:
            bs_html = render_widget_to_html(w.children[0])
        return "<div style=\"" + bs_style + "\"><div style=\"width: 40px; height: 4px; background-color: #484f58; border-radius: 2px; margin: 0 auto 16px auto;\"></div>" + bs_html + "</div>"

    // 38: ExpansionTile / Accordion
    if k == 38:
        let mut op_attr: string = ""
        if w.is_checked:
            op_attr = " open"
        let exp_style: string = "background-color: " + w.bg_color + "; border: 1px solid #30363d; border-radius: 8px; padding: 12px 16px; color: #e6edf3;"
        let mut body_h: string = ""
        let mut ei: int = 0
        while ei < len(w.children):
            body_h = body_h + render_widget_to_html(w.children[ei])
            ei = ei + 1
        return "<details style=\"" + exp_style + "\"" + op_attr + "><summary style=\"cursor: pointer; font-weight: 600; outline: none;\">" + w.text + "</summary><div style=\"padding-top: 12px; display: flex; flex-direction: column; gap: 8px;\">" + body_h + "</div></details>"

    // 39: Alert
    if k == 39:
        let al_style: string = "background-color: " + w.bg_color + "; border: 1px solid " + w.color + "; border-radius: 8px; padding: 12px 16px; color: " + w.color + "; font-size: 14px; display: flex; flex-direction: column; gap: 4px;"
        let mut msg_h: string = ""
        if len(w.subtitle) > 0:
            msg_h = "<span style=\"color: #e6edf3; font-size: 13px; opacity: 0.9;\">" + w.subtitle + "</span>"
        return "<div style=\"" + al_style + "\"><strong style=\"font-weight: 600;\">" + w.text + "</strong>" + msg_h + "</div>"

    // 40: Icon
    if k == 40:
        return "<span style=\"font-size: " + str(w.font_size) + "px; color: " + w.color + "; display: inline-flex; align-items: center; justify-content: center;\">[" + w.icon_name + "]</span>"

    // 41: Stepper
    if k == 41:
        let mut st_label: string = ""
        if len(w.text) > 0:
            st_label = "<span style=\"font-size: 13px; color: #e6edf3; margin-right: 4px;\">" + w.text + "</span>"
        let st_box: string = "display: inline-flex; align-items: center; gap: 8px; background-color: " + w.bg_color + "; border: 1px solid #30363d; border-radius: 6px; padding: 4px 8px;"
        let btn_st: string = "background-color: #21262d; border: 1px solid #30363d; color: #e6edf3; width: 26px; height: 26px; border-radius: 4px; cursor: pointer; display: inline-flex; align-items: center; justify-content: center; font-weight: bold; font-size: 14px;"
        return "<div style=\"" + st_box + "\">" + st_label + "<button style=\"" + btn_st + "\">-</button><span style=\"font-weight: 600; min-width: 24px; text-align: center; color: " + w.color + "; font-size: 14px;\">" + str(w.value) + "</span><button style=\"" + btn_st + "\">+</button></div>"

    // 42: SegmentedButton
    if k == 42:
        let seg_wrap: string = "display: inline-flex; background-color: #0d1117; border: 1px solid #30363d; border-radius: 8px; padding: 3px; gap: 2px;"
        let mut seg_btns: string = ""
        let mut si: int = 0
        while si < len(w.options):
            let mut opt_style: string = "border: none; padding: 6px 14px; border-radius: 6px; font-size: 13px; cursor: pointer; transition: all 0.15s ease;"
            if si == w.active_index:
                opt_style = opt_style + " background-color: #238636; color: #ffffff; font-weight: 600;"
            else:
                opt_style = opt_style + " background-color: transparent; color: #8b949e; font-weight: 400;"
            seg_btns = seg_btns + "<button style=\"" + opt_style + "\">" + w.options[si] + "</button>"
            si = si + 1
        return "<div style=\"" + seg_wrap + "\">" + seg_btns + "</div>"

    // 43: Tooltip
    if k == 43:
        let mut child_h: string = ""
        if len(w.children) > 0:
            child_h = render_widget_to_html(w.children[0])
        return "<div style=\"position: relative; display: inline-block; cursor: help;\" title=\"" + w.text + "\">" + child_h + "</div>"

    // 44: NavigationRail
    if k == 44:
        let nr_style: string = "width: " + str(w.width) + "px; min-height: 100vh; background-color: " + w.bg_color + "; border-right: 1px solid #30363d; display: flex; flex-direction: column; padding: 16px 10px; gap: 8px; box-sizing: border-box;"
        let mut nr_items: string = ""
        let mut nri: int = 0
        while nri < len(w.children):
            nr_items = nr_items + render_widget_to_html(w.children[nri])
            nri = nri + 1
        return "<nav style=\"" + nr_style + "\">" + nr_items + "</nav>"

    // 45: DataTable
    if k == 45:
        let dt_wrap: string = "width: 100%; overflow-x: auto; border: 1px solid #30363d; border-radius: 8px; background-color: " + w.bg_color + ";"
        let mut th_row: string = ""
        let mut hi: int = 0
        while hi < len(w.options):
            th_row = th_row + "<th style=\"padding: 10px 14px; font-weight: 600; color: #8b949e; border-bottom: 1px solid #30363d; font-size: 13px;\">" + w.options[hi] + "</th>"
            hi = hi + 1
        let mut tb_rows: string = ""
        let mut ri: int = 0
        while ri < len(w.children):
            let r_widget: Widget = w.children[ri]
            tb_rows = tb_rows + "<tr style=\"border-bottom: 1px solid #21262d;\">"
            let mut ci: int = 0
            while ci < len(r_widget.children):
                tb_rows = tb_rows + "<td style=\"padding: 10px 14px; font-size: 13px; color: #e6edf3;\">" + render_widget_to_html(r_widget.children[ci]) + "</td>"
                ci = ci + 1
            tb_rows = tb_rows + "</tr>"
            ri = ri + 1
        return "<div style=\"" + dt_wrap + "\"><table style=\"width: 100%; border-collapse: collapse; text-align: left;\"><thead><tr style=\"background-color: #21262d;\">" + th_row + "</tr></thead><tbody>" + tb_rows + "</tbody></table></div>"

    // 46: Rating
    if k == 46:
        let mut stars: string = ""
        let mut s_idx: int = 1
        while s_idx <= w.max_value:
            if s_idx <= w.value:
                stars = stars + "<span style=\"color: " + w.color + ";\">&#9733;</span>"
            else:
                stars = stars + "<span style=\"color: #484f58;\">&#9734;</span>"
            s_idx = s_idx + 1
        return "<div style=\"display: inline-flex; gap: 3px; font-size: " + str(w.font_size) + "px; user-select: none;\">" + stars + "</div>"

    // 47: Skeleton
    if k == 47:
        let sk_style: string = "width: " + str(w.width) + "px; height: " + str(w.height) + "px; border-radius: " + str(w.border_radius) + "px; background: linear-gradient(90deg, #21262d 25%, #30363d 50%, #21262d 75%); background-size: 200% 100%; animation: cl_shimmer 1.5s infinite;"
        return "<div style=\"" + sk_style + "\"></div>"

    // 48: Breadcrumbs
    if k == 48:
        let mut bc_items: string = ""
        let mut bci: int = 0
        let total_bc: int = len(w.options)
        while bci < total_bc:
            if bci > 0:
                bc_items = bc_items + "<span style=\"color: #484f58; margin: 0 4px;\">/</span>"
            if bci == total_bc - 1:
                bc_items = bc_items + "<span style=\"color: #e6edf3; font-weight: 600;\">" + w.options[bci] + "</span>"
            else:
                bc_items = bc_items + "<span style=\"color: " + w.color + "; cursor: pointer;\">" + w.options[bci] + "</span>"
            bci = bci + 1
        return "<nav style=\"display: flex; align-items: center; gap: 4px; font-size: 13px; flex-wrap: wrap;\">" + bc_items + "</nav>"

    // 49: CodeBlock
    if k == 49:
        let cb_wrap: string = "background-color: " + w.bg_color + "; border: 1px solid #30363d; border-radius: " + str(w.border_radius) + "px; overflow: hidden; font-family: ui-monospace, SFMono-Regular, Menlo, Monaco, Consolas, monospace; font-size: 13px; width: 100%; box-sizing: border-box;"
        let cb_bar: string = "display: flex; justify-content: space-between; align-items: center; background-color: #161b22; padding: 6px 12px; border-bottom: 1px solid #30363d; font-size: 11px; color: #8b949e; text-transform: uppercase;"
        return "<div style=\"" + cb_wrap + "\"><div style=\"" + cb_bar + "\"><span>" + w.value_str + "</span><span style=\"cursor: pointer;\">Copy</span></div><pre style=\"padding: " + str(w.padding) + "px; margin: 0; overflow-x: auto; color: " + w.color + "; line-height: 1.5;\"><code>" + w.text + "</code></pre></div>"

    // 50: MetricCard
    if k == 50:
        let mc_style: string = "background-color: " + w.bg_color + "; border: 1px solid #30363d; border-radius: " + str(w.border_radius) + "px; padding: " + str(w.padding) + "px; display: flex; flex-direction: column; gap: 8px; min-width: 180px; box-sizing: border-box; box-shadow: 0 4px 12px rgba(0,0,0,0.25);"
        let mut trend_h: string = ""
        if len(w.subtitle) > 0:
            let mut arr: string = "&#8595; "
            let mut t_col: string = "#f85149"
            if w.is_checked:
                arr = "&#8593; "
                t_col = "#3fb950"
            trend_h = "<div style=\"display: inline-flex; align-items: center; gap: 4px; font-size: 12px; font-weight: 500; color: " + t_col + ";\"><span>" + arr + "</span><span>" + w.subtitle + "</span></div>"
        return "<div style=\"" + mc_style + "\"><div style=\"display: flex; justify-content: space-between; align-items: center; color: #8b949e; font-size: 13px;\"><span>" + w.text + "</span><span style=\"color: " + w.color + "; font-size: 15px;\">[" + w.icon_name + "]</span></div><div style=\"font-size: 24px; font-weight: 700; color: #e6edf3;\">" + w.value_str + "</div>" + trend_h + "</div>"

    // 51: RawHtml / Custom Component
    if k == 51:
        return w.text

    return ""

fn render_page_html(title: string, root_widget: Widget) -> string:
    let mut doc: string = "<!DOCTYPE html>\n<html>\n<head>\n"
    doc = doc + "    <meta charset=\"utf-8\">\n"
    doc = doc + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
    doc = doc + "    <title>" + title + "</title>\n"
    doc = doc + "    <style>\n"
    doc = doc + "        * { box-sizing: border-box; margin: 0; padding: 0; }\n"
    doc = doc + "        body { background-color: #0d1117; color: #e6edf3; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 20px; }\n"
    doc = doc + "        @keyframes cl_spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }\n"
    doc = doc + "        @keyframes cl_shimmer { 0% { background-position: -200% 0; } 100% { background-position: 200% 0; } }\n"
    doc = doc + "    </style>\n"
    doc = doc + "</head>\n<body>\n"
    doc = doc + render_widget_to_html(root_widget) + "\n"
    doc = doc + "<script>\n"
    doc = doc + "window.Cluster = {\n"
    doc = doc + "    state: {},\n"
    doc = doc + "    get: function(k) { return this.state[k] || 0; },\n"
    doc = doc + "    set: function(k, v) {\n"
    doc = doc + "        this.state[k] = v;\n"
    doc = doc + "        var els = document.querySelectorAll('[data-bind=\"' + k + '\"]');\n"
    doc = doc + "        for (var i = 0; i < els.length; i++) {\n"
    doc = doc + "            if (els[i].tagName === 'INPUT' || els[i].tagName === 'SELECT') els[i].value = v;\n"
    doc = doc + "            else els[i].innerText = v;\n"
    doc = doc + "        }\n"
    doc = doc + "    },\n"
    doc = doc + "    dispatch: function(action, payload) {\n"
    doc = doc + "        if (window.__cluster_reducer) {\n"
    doc = doc + "            window.__cluster_reducer(this.state, action, payload);\n"
    doc = doc + "            for (var k in this.state) { this.set(k, this.state[k]); }\n"
    doc = doc + "        }\n"
    doc = doc + "    }\n"
    doc = doc + "};\n"
    doc = doc + "</script>\n"
    doc = doc + "</body>\n</html>"
    return doc
