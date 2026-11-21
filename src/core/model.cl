// ==============================================================================
// Cluster UI: Core Widget Model & Base Factory
// 100% Pure Cluster Language — Zero External Runtimes
// ==============================================================================

model Widget:
    kind: int             // 1:Text, 2:Button, 3:Column/VStack, 4:Row/HStack, 5:Box/Container,
                          // 6:Spacer, 7:TextInput, 8:Image, 9:ZStack/Stack, 10:Divider,
                          // 11:Card, 12:Badge/Chip, 13:Toggle/Switch, 14:ProgressBar,
                          // 15:ListTile, 16:Center, 17:Link, 18:Expanded, 19:AppBar,
                          // 20:BottomNavigationBar, 21:TabItem, 22:FloatingActionButton,
                          // 23:Dialog, 24:SnackBar, 25:Grid, 26:Wrap, 27:Avatar, 28:Dropdown,
                          // 29:Scaffold, 30:ScrollView, 31:Slider, 32:Checkbox, 33:Radio,
                          // 34:Chip, 35:CircularProgressIndicator, 36:Drawer, 37:BottomSheet,
                          // 38:ExpansionTile, 39:Alert, 40:Icon, 41:Stepper, 42:SegmentedButton,
                          // 43:Tooltip, 44:NavigationRail, 45:DataTable, 46:Rating, 47:Skeleton,
                          // 48:Breadcrumbs, 49:CodeBlock, 50:MetricCard
    id: string
    text: string
    font_size: int
    bold: bool
    color: string
    bg_color: string
    width: int
    height: int
    padding: int
    margin: int
    border_radius: int
    border_color: string
    border_width: int
    spacing: int
    on_click: string
    placeholder: string
    image_url: string
    url: string
    subtitle: string
    icon_name: string
    value: int
    min_value: int
    max_value: int
    on_change: string
    on_delete: string
    value_str: string
    is_checked: bool
    shadow: bool
    align: string
    flex: int
    columns: int
    active_index: int
    badge_count: int
    is_online: bool
    bind_key: string
    is_animated: bool
    anim_curve: string
    anim_duration: int
    options: vector[string]
    children: vector[Widget]

// Base factory to initialize defaults
fn new_widget(kind: int) -> Widget:
    let empty_ch: vector[Widget] = []
    let empty_opts: vector[string] = []
    return Widget(
        kind = kind,
        id = "",
        text = "",
        font_size = 0,
        bold = false,
        color = "",
        bg_color = "",
        width = 0,
        height = 0,
        padding = 0,
        margin = 0,
        border_radius = 0,
        border_color = "",
        border_width = 0,
        spacing = 0,
        on_click = "",
        placeholder = "",
        image_url = "",
        url = "",
        subtitle = "",
        icon_name = "",
        value = 0,
        min_value = 0,
        max_value = 100,
        on_change = "",
        on_delete = "",
        value_str = "",
        is_checked = false,
        shadow = false,
        align = "",
        flex = 0,
        columns = 0,
        active_index = 0,
        badge_count = 0,
        is_online = false,
        bind_key = "",
        is_animated = false,
        anim_curve = "",
        anim_duration = 0,
        options = empty_opts,
        children = empty_ch
    )
