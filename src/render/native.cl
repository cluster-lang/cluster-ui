// ==============================================================================
// Cluster UI: Native GPU Hardware Window Renderer (X11 + OpenGL / GLX)
// 100% Pure Cluster Language — zero C sources, dlopen/dlsym runtime binding.
// Renders declarative `std/ui` Widget trees directly on the GPU at 60+ FPS.
// ==============================================================================

extern fn dlopen(name: ptr, mode: int) -> ptr
extern fn dlsym(handle: ptr, sym: ptr) -> ptr
extern fn getenv(name: ptr) -> ptr
extern fn usleep(usec: int) -> int
extern fn clock_gettime(clk_id: int, ts: ptr) -> int

s_ui_nat_init := 0
s_ui_nat_dpy := 0
s_ui_nat_win := 0
s_ui_nat_ctx := 0
s_ui_nat_w := 1024
s_ui_nat_h := 640
s_ui_nat_ev_buf := 0
s_ui_nat_ortho := 0
s_ui_nat_ts := 0
s_ui_nat_should_close := 0

p_ui_XOpenDisplay := 0
p_ui_XDefaultScreen := 0
p_ui_XRootWindow := 0
p_ui_XCreateSimpleWindow := 0
p_ui_XStoreName := 0
p_ui_XSelectInput := 0
p_ui_XMapWindow := 0
p_ui_XPending := 0
p_ui_XNextEvent := 0
p_ui_XCloseDisplay := 0

p_ui_glXChooseFBConfig := 0
p_ui_glXCreateNewContext := 0
p_ui_glXMakeCurrent := 0
p_ui_glXSwapBuffers := 0
p_ui_glViewport := 0
p_ui_glMatrixMode := 0
p_ui_glLoadIdentity := 0
p_ui_glLoadMatrixf := 0
p_ui_glColor4ub := 0
p_ui_glRecti := 0
p_ui_glFinish := 0

fn _ui_nat_hex_nibble(b: int) -> int:
    if b >= 48 and b <= 57:
        return b - 48
    if b >= 97 and b <= 102:
        return b - 87
    if b >= 65 and b <= 70:
        return b - 55
    return 0

fn _ui_nat_hex_byte(s: string, off: int) -> int:
    if off + 1 >= len(s):
        return 0
    return (_ui_nat_hex_nibble(byte_at(s, off)) * 16) + _ui_nat_hex_nibble(byte_at(s, off + 1))

fn _ui_nat_set_hex_color(hex_c: string, fallback_r: int, fallback_g: int, fallback_b: int):
    if p_ui_glColor4ub == 0:
        return
    r := fallback_r
    g := fallback_g
    b := fallback_b
    if len(hex_c) >= 7 and byte_at(hex_c, 0) == 35:
        r = _ui_nat_hex_byte(hex_c, 1)
        g = _ui_nat_hex_byte(hex_c, 3)
        b = _ui_nat_hex_byte(hex_c, 5)
    call_ptr4(p_ui_glColor4ub, r, g, b, 255)

fn _ui_nat_rect(x: int, y: int, w: int, h: int):
    if p_ui_glRecti == 0 or w <= 0 or h <= 0:
        return
    call_ptr4(p_ui_glRecti, x, y, x + w, y + h)

/// Compact 3x5 pixel bitmap rows (bits 14..0, top-left MSB) for printable ASCII.
fn _ui_nat_glyph_bits(ch: int) -> int:
    c := ch
    if c >= 97 and c <= 122:
        c = c - 32
    if c == 65: return 11245 // A
    if c == 66: return 27566 // B
    if c == 67: return 14627 // C
    if c == 68: return 27502 // D
    if c == 69: return 31143 // E
    if c == 70: return 31140 // F
    if c == 71: return 14699 // G
    if c == 72: return 23533 // H
    if c == 73: return 29847 // I
    if c == 74: return 4719  // J
    if c == 75: return 23469 // K
    if c == 76: return 18727 // L
    if c == 77: return 24429 // M
    if c == 78: return 23549 // N
    if c == 79: return 11114 // O
    if c == 80: return 27556 // P
    if c == 81: return 11131 // Q
    if c == 82: return 27565 // R
    if c == 83: return 14478 // S
    if c == 84: return 29842 // T
    if c == 85: return 23407 // U
    if c == 86: return 23378 // V
    if c == 87: return 23546 // W
    if c == 88: return 23213 // X
    if c == 89: return 23186 // Y
    if c == 90: return 29351 // Z
    if c == 48: return 31599 // 0
    if c == 49: return 9362  // 1
    if c == 50: return 29671 // 2
    if c == 51: return 29391 // 3
    if c == 52: return 23497 // 4
    if c == 53: return 31183 // 5
    if c == 54: return 18927 // 6
    if c == 55: return 29257 // 7
    if c == 56: return 31727 // 8
    if c == 57: return 31689 // 9
    if c == 58: return 1040  // :
    if c == 46: return 2     // .
    if c == 45: return 448   // -
    if c == 43: return 1488  // +
    if c == 47: return 4676  // /
    if c == 37: return 21061 // %
    return 0

fn _ui_nat_draw_text(s: string, x: int, y: int, font_px: int, hex_col: string):
    if len(s) == 0 or s_ui_nat_ctx == 0:
        return
    scale := font_px / 6
    if scale < 2:
        scale = 2
    _ui_nat_set_hex_color(hex_col, 230, 237, 243)
    cx := x
    n := len(s)
    i := 0
    while i < n:
        ch := byte_at(s, i)
        if ch != 32:
            bits := _ui_nat_glyph_bits(ch)
            row := 0
            while row < 5:
                col := 0
                while col < 3:
                    shift := ((4 - row) * 3) + (2 - col)
                    if ((bits >> shift) & 1) == 1:
                        _ui_nat_rect(cx + (col * scale), y + (row * scale), scale, scale)
                    col = col + 1
                row = row + 1
        cx = cx + (scale * 4)
        i = i + 1

fn _ui_nat_time_ns() -> int:
    if s_ui_nat_ts == 0:
        return 0
    ts_p := int_to_ptr(s_ui_nat_ts)
    clock_gettime(1, ts_p)
    sec := ptr_read(ts_p)
    nsec := ptr_read(ptr_add(ts_p, 8))
    return (sec * 1000000000) + nsec

fn ui_native_now_ms() -> int:
    if s_ui_nat_ts == 0:
        s_ui_nat_ts = ptr_to_int(mem_alloc(16))
    return _ui_nat_time_ns() / 1000000

fn _ui_nat_measure_h(w: Widget) -> int:
    k := w.kind
    if k == 1:
        fs := w.font_size
        if fs <= 0: fs = 14
        return fs + 8
    if k == 2:
        if w.height > 0: return w.height
        return 36
    if k == 10:
        return 6
    if k == 14:
        return 14
    if k == 50:
        return 76
    pad := w.padding
    if pad <= 0 and (k == 11 or k == 5): pad = 12
    sp := w.spacing
    if sp <= 0: sp = 8
    if k == 4:
        max_h := 44
        i := 0
        while i < len(w.children):
            ch := _ui_nat_measure_h(w.children[i])
            if ch > max_h: max_h = ch
            i = i + 1
        return max_h + (pad * 2)
    total := pad * 2
    i := 0
    while i < len(w.children):
        total = total + _ui_nat_measure_h(w.children[i])
        if i > 0: total = total + sp
        i = i + 1
    if w.height > total:
        return w.height
    if total < 40:
        return 40
    return total

fn _ui_nat_render_node(w: Widget, x: int, y: int, avail_w: int, avail_h: int) -> int:
    k := w.kind
    if k == 1:
        fs := w.font_size
        if fs <= 0: fs = 14
        col := w.color
        if col == "": col = "#e6edf3"
        _ui_nat_draw_text(w.text, x + 2, y + 4, fs, col)
        return fs + 8

    if k == 2:
        bw := w.width
        if bw <= 0:
            bw = (len(w.text) * 10) + 28
            if bw < 120: bw = 120
        if bw > avail_w: bw = avail_w
        bh := w.height
        if bh <= 0: bh = 36
        bg := w.bg_color
        if bg == "": bg = "#238636"
        _ui_nat_set_hex_color(bg, 35, 134, 54)
        _ui_nat_rect(x, y, bw, bh)
        tc := w.color
        if tc == "": tc = "#ffffff"
        _ui_nat_draw_text(w.text, x + 12, y + 11, 14, tc)
        return bh

    if k == 10:
        dc := w.color
        if dc == "": dc = "#30363d"
        _ui_nat_set_hex_color(dc, 48, 54, 61)
        _ui_nat_rect(x, y + 2, avail_w, 2)
        return 6

    if k == 12:
        bw := (len(w.text) * 9) + 18
        if bw > avail_w: bw = avail_w
        bg := w.bg_color
        if bg == "": bg = "#1f6feb"
        _ui_nat_set_hex_color(bg, 31, 111, 235)
        _ui_nat_rect(x, y + 2, bw, 24)
        _ui_nat_draw_text(w.text, x + 8, y + 7, 12, "#ffffff")
        return 28

    if k == 14:
        _ui_nat_set_hex_color("#21262d", 33, 38, 45)
        _ui_nat_rect(x, y + 2, avail_w, 10)
        pct := w.value
        if pct < 0: pct = 0
        if pct > 100: pct = 100
        fw := (avail_w * pct) / 100
        bar_c := w.color
        if bar_c == "": bar_c = "#238636"
        _ui_nat_set_hex_color(bar_c, 35, 134, 54)
        _ui_nat_rect(x, y + 2, fw, 10)
        return 14

    if k == 50:
        mh := 76
        _ui_nat_set_hex_color("#161b22", 22, 27, 34)
        _ui_nat_rect(x, y, avail_w, mh)
        acc := w.color
        if acc == "": acc = "#58a6ff"
        _ui_nat_set_hex_color(acc, 88, 166, 255)
        _ui_nat_rect(x, y, 4, mh)
        _ui_nat_draw_text(w.text, x + 14, y + 12, 12, "#8b949e")
        _ui_nat_draw_text(w.value_str, x + 14, y + 36, 20, "#e6edf3")
        return mh

    if k == 29:
        bg := w.bg_color
        if bg == "": bg = "#0d1117"
        _ui_nat_set_hex_color(bg, 13, 17, 23)
        _ui_nat_rect(x, y, avail_w, avail_h)
        cy := y + 16
        i := 0
        while i < len(w.children):
            ch_h := _ui_nat_render_node(w.children[i], x + 20, cy, avail_w - 40, avail_h - (cy - y))
            cy = cy + ch_h + 12
            i = i + 1
        return avail_h

    if k == 11 or k == 5 or k == 16:
        pad := w.padding
        if pad <= 0: pad = 12
        cw := w.width
        if cw <= 0 or cw > avail_w: cw = avail_w
        ch := _ui_nat_measure_h(w)
        bg := w.bg_color
        if bg == "" and k == 11: bg = "#161b22"
        if bg != "":
            _ui_nat_set_hex_color(bg, 22, 27, 34)
            _ui_nat_rect(x, y, cw, ch)
        cy := y + pad
        i := 0
        while i < len(w.children):
            used := _ui_nat_render_node(w.children[i], x + pad, cy, cw - (pad * 2), ch - (pad * 2))
            cy = cy + used + 8
            i = i + 1
        return ch

    if k == 4:
        nc := len(w.children)
        if nc == 0:
            return 0
        sp := w.spacing
        if sp <= 0: sp = 10
        cell_w := (avail_w - (sp * (nc - 1))) / nc
        if cell_w < 40: cell_w = 40
        max_h := 0
        cx := x
        i := 0
        while i < nc:
            rh := _ui_nat_render_node(w.children[i], cx, y, cell_w, avail_h)
            if rh > max_h: max_h = rh
            cx = cx + cell_w + sp
            i = i + 1
        return max_h

    // Default vertical container / Column (k == 3)
    sp := w.spacing
    if sp <= 0: sp = 8
    pad := w.padding
    cy := y + pad
    i := 0
    while i < len(w.children):
        used := _ui_nat_render_node(w.children[i], x + pad, cy, avail_w - (pad * 2), avail_h)
        cy = cy + used + sp
        i = i + 1
    return cy - y + pad

fn ui_native_open(title: string, width: int, height: int) -> int:
    s_ui_nat_w = width
    s_ui_nat_h = height
    s_ui_nat_should_close = 0
    if s_ui_nat_ev_buf == 0:
        s_ui_nat_ev_buf = ptr_to_int(mem_alloc(256))
    if s_ui_nat_ortho == 0:
        s_ui_nat_ortho = ptr_to_int(mem_alloc(64))
    if s_ui_nat_ts == 0:
        s_ui_nat_ts = ptr_to_int(mem_alloc(16))
    if s_ui_nat_init == 1:
        return 1

    xlib: ptr := dlopen(str_cstr("libX11.so.6"), 1)
    if xlib == null:
        xlib = dlopen(str_cstr("libX11.so"), 1)
    glib: ptr := dlopen(str_cstr("libGL.so.1"), 1)
    if glib == null:
        glib = dlopen(str_cstr("libGL.so"), 1)
    if xlib == null or glib == null:
        return 0

    p_ui_XOpenDisplay = ptr_to_int(dlsym(xlib, str_cstr("XOpenDisplay")))
    p_ui_XDefaultScreen = ptr_to_int(dlsym(xlib, str_cstr("XDefaultScreen")))
    p_ui_XRootWindow = ptr_to_int(dlsym(xlib, str_cstr("XRootWindow")))
    p_ui_XCreateSimpleWindow = ptr_to_int(dlsym(xlib, str_cstr("XCreateSimpleWindow")))
    p_ui_XStoreName = ptr_to_int(dlsym(xlib, str_cstr("XStoreName")))
    p_ui_XSelectInput = ptr_to_int(dlsym(xlib, str_cstr("XSelectInput")))
    p_ui_XMapWindow = ptr_to_int(dlsym(xlib, str_cstr("XMapWindow")))
    p_ui_XPending = ptr_to_int(dlsym(xlib, str_cstr("XPending")))
    p_ui_XNextEvent = ptr_to_int(dlsym(xlib, str_cstr("XNextEvent")))
    p_ui_XCloseDisplay = ptr_to_int(dlsym(xlib, str_cstr("XCloseDisplay")))

    p_ui_glXChooseFBConfig = ptr_to_int(dlsym(glib, str_cstr("glXChooseFBConfig")))
    p_ui_glXCreateNewContext = ptr_to_int(dlsym(glib, str_cstr("glXCreateNewContext")))
    p_ui_glXMakeCurrent = ptr_to_int(dlsym(glib, str_cstr("glXMakeCurrent")))
    p_ui_glXSwapBuffers = ptr_to_int(dlsym(glib, str_cstr("glXSwapBuffers")))
    p_ui_glViewport = ptr_to_int(dlsym(glib, str_cstr("glViewport")))
    p_ui_glMatrixMode = ptr_to_int(dlsym(glib, str_cstr("glMatrixMode")))
    p_ui_glLoadIdentity = ptr_to_int(dlsym(glib, str_cstr("glLoadIdentity")))
    p_ui_glLoadMatrixf = ptr_to_int(dlsym(glib, str_cstr("glLoadMatrixf")))
    p_ui_glColor4ub = ptr_to_int(dlsym(glib, str_cstr("glColor4ub")))
    p_ui_glRecti = ptr_to_int(dlsym(glib, str_cstr("glRecti")))
    p_ui_glFinish = ptr_to_int(dlsym(glib, str_cstr("glFinish")))

    if p_ui_XOpenDisplay == 0 or p_ui_glXChooseFBConfig == 0 or p_ui_glXCreateNewContext == 0:
        return 0

    dpy_env := ptr_to_int(getenv(str_cstr("DISPLAY")))
    if dpy_env == 0:
        dpy_env = ptr_to_int(str_cstr(":0"))
    s_ui_nat_dpy = call_ptr1(p_ui_XOpenDisplay, dpy_env)
    if s_ui_nat_dpy == 0:
        s_ui_nat_dpy = call_ptr1(p_ui_XOpenDisplay, ptr_to_int(str_cstr(":0")))
    if s_ui_nat_dpy == 0:
        return 0

    scr := call_ptr1(p_ui_XDefaultScreen, s_ui_nat_dpy)
    vis_attr: ptr := mem_alloc(36)
    ptr_write_i32(vis_attr, 8)
    ptr_write_i32(ptr_add(vis_attr, 4), 8)
    ptr_write_i32(ptr_add(vis_attr, 8), 9)
    ptr_write_i32(ptr_add(vis_attr, 12), 8)
    ptr_write_i32(ptr_add(vis_attr, 16), 10)
    ptr_write_i32(ptr_add(vis_attr, 20), 8)
    ptr_write_i32(ptr_add(vis_attr, 24), 5)
    ptr_write_i32(ptr_add(vis_attr, 28), 1)
    ptr_write_i32(ptr_add(vis_attr, 32), 0)

    nf_p: ptr := mem_alloc(4)
    ptr_write_i32(nf_p, 0)
    fbc_arr := call_ptr4(p_ui_glXChooseFBConfig, s_ui_nat_dpy, scr, ptr_to_int(vis_attr), ptr_to_int(nf_p))
    nf := ptr_read_i32(nf_p)
    mem_free(vis_attr)
    mem_free(nf_p)
    if fbc_arr == 0 or nf <= 0:
        return 0

    fbc0 := ptr_read(int_to_ptr(fbc_arr))
    s_ui_nat_ctx = call_ptr5(p_ui_glXCreateNewContext, s_ui_nat_dpy, fbc0, 32788, 0, 1)
    if s_ui_nat_ctx == 0:
        return 0

    root_w := call_ptr2(p_ui_XRootWindow, s_ui_nat_dpy, scr)
    s_ui_nat_win = call_ptr9(p_ui_XCreateSimpleWindow, s_ui_nat_dpy, root_w, 40, 40, width, height, 0, 0, 855831)
    if s_ui_nat_win == 0:
        return 0
    if p_ui_XStoreName != 0:
        call_ptr3(p_ui_XStoreName, s_ui_nat_dpy, s_ui_nat_win, ptr_to_int(str_cstr(title)))
    if p_ui_XSelectInput != 0:
        call_ptr3(p_ui_XSelectInput, s_ui_nat_dpy, s_ui_nat_win, 32773)
    if p_ui_XMapWindow != 0:
        call_ptr2(p_ui_XMapWindow, s_ui_nat_dpy, s_ui_nat_win)
    if call_ptr3(p_ui_glXMakeCurrent, s_ui_nat_dpy, s_ui_nat_win, s_ui_nat_ctx) == 0:
        return 0

    // Set 2D top-left orthographic projection matrix via ptr_write_f32
    ortho_p := int_to_ptr(s_ui_nat_ortho)
    zi := 0
    while zi < 16:
        ptr_write_f32(ptr_add(ortho_p, zi * 4), 0.0)
        zi = zi + 1
    sx := 2.0 / to_float(width)
    sy := 0.0 - (2.0 / to_float(height))
    ptr_write_f32(ptr_add(ortho_p, 0), sx)
    ptr_write_f32(ptr_add(ortho_p, 20), sy)
    ptr_write_f32(ptr_add(ortho_p, 40), -1.0)
    ptr_write_f32(ptr_add(ortho_p, 48), -1.0)
    ptr_write_f32(ptr_add(ortho_p, 52), 1.0)
    ptr_write_f32(ptr_add(ortho_p, 60), 1.0)

    if p_ui_glViewport != 0:
        call_ptr4(p_ui_glViewport, 0, 0, width, height)
    if p_ui_glMatrixMode != 0 and p_ui_glLoadMatrixf != 0:
        call_ptr1(p_ui_glMatrixMode, 5889)
        call_ptr1(p_ui_glLoadMatrixf, s_ui_nat_ortho)
        call_ptr1(p_ui_glMatrixMode, 5888)
        if p_ui_glLoadIdentity != 0:
            call_ptr0(p_ui_glLoadIdentity)

    s_ui_nat_init = 1
    return 1

fn ui_native_begin_frame():
    if s_ui_nat_init == 1:
        _ui_nat_set_hex_color("#0d1117", 13, 17, 23)
        _ui_nat_rect(0, 0, s_ui_nat_w, s_ui_nat_h)

fn ui_native_render_widget(root: Widget):
    if s_ui_nat_init == 1:
        _ui_nat_render_node(root, 0, 0, s_ui_nat_w, s_ui_nat_h)

fn ui_native_end_frame():
    if s_ui_nat_init == 1:
        if p_ui_glXSwapBuffers != 0:
            call_ptr2(p_ui_glXSwapBuffers, s_ui_nat_dpy, s_ui_nat_win)
        if p_ui_glFinish != 0:
            call_ptr0(p_ui_glFinish)

fn ui_native_poll_close() -> int:
    if s_ui_nat_init == 0 or p_ui_XPending == 0 or p_ui_XNextEvent == 0:
        return s_ui_nat_should_close
    ev_p := int_to_ptr(s_ui_nat_ev_buf)
    while call_ptr1(p_ui_XPending, s_ui_nat_dpy) > 0:
        call_ptr2(p_ui_XNextEvent, s_ui_nat_dpy, s_ui_nat_ev_buf)
        ev_type := ptr_read_i32(ev_p)
        if ev_type == 2:
            kc := ptr_read_i32(ptr_add(ev_p, 84))
            if kc == 9:
                s_ui_nat_should_close = 1
        elif ev_type == 17 or ev_type == 33:
            s_ui_nat_should_close = 1
    return s_ui_nat_should_close

fn ui_native_close():
    if s_ui_nat_init == 1 and p_ui_XCloseDisplay != 0 and s_ui_nat_dpy != 0:
        call_ptr1(p_ui_XCloseDisplay, s_ui_nat_dpy)
    s_ui_nat_init = 0
    s_ui_nat_dpy = 0
    s_ui_nat_win = 0
    s_ui_nat_ctx = 0

/// Open a native X11/OpenGL window, render the Widget tree up to `max_frames` (0 = interactive) at 60 FPS, and return measured FPS.
fn ui_run_native(title: string, width: int, height: int, root: Widget, max_frames: int) -> float:
    has_gpu_win := ui_native_open(title, width, height)
    if s_ui_nat_ts == 0:
        s_ui_nat_ts = ptr_to_int(mem_alloc(16))
    target_ns := 15500000
    t_start := _ui_nat_time_ns()
    frames := 0
    while ui_native_poll_close() == 0:
        f0 := _ui_nat_time_ns()
        if has_gpu_win == 1:
            ui_native_begin_frame()
            ui_native_render_widget(root)
            ui_native_end_frame()
        frames = frames + 1
        if max_frames > 0 and frames >= max_frames:
            break
        elapsed_f := _ui_nat_time_ns() - f0
        if elapsed_f < target_ns:
            rem_us := (target_ns - elapsed_f) / 1000
            if rem_us > 100:
                usleep(rem_us)
    t_end := _ui_nat_time_ns()
    if has_gpu_win == 1:
        ui_native_close()
    dt_ns := t_end - t_start
    if dt_ns <= 0:
        return 60.0
    return (to_float(frames) * 1000000000.0) / to_float(dt_ns)
