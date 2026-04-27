config.load_autoconfig(False)

# =============================================================================
# General
# =============================================================================

c.auto_save.session = True
c.session.lazy_restore = True
c.confirm_quit = ["downloads"]
c.downloads.remove_finished = 5000
c.editor.command = ["kitty", "-e", "nvim", "{}"]

c.input.forward_unbound_keys = "auto"
c.scrolling.smooth = True
c.scrolling.bar = "never"

c.content.autoplay = False
c.content.blocking.enabled = True
c.content.blocking.method = "adblock"
c.content.blocking.adblock.lists = [
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.com.au/fanboy-cookiemonster.txt",
    "https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt",
    "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt",
]

c.content.javascript.clipboard = "access"
c.content.notifications.enabled = False
c.content.geolocation = False

c.tabs.show = "multiple"
c.tabs.position = "top"
c.tabs.last_close = "close"
c.tabs.mousewheel_switching = False
c.tabs.favicons.show = "always"
c.tabs.title.format = "{audio}{index}: {current_title}"
c.tabs.title.format_pinned = "{audio}{index}"

c.url.default_page = "about:blank"
c.url.start_pages = ["about:blank"]
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "yt": "https://youtube.com/search?q={}",
    "gh": "https://github.com/search?q={}",
    "nix": "https://search.nixos.org/packages?query={}",
    "nixo": "https://search.nixos.org/options?query={}",
    "mdn": "https://developer.mozilla.org/en-US/search?q={}",
    "py": "https://docs.python.org/3/search.html?q={}",
    "wa": "https://wolframalpha.com/input?i={}",
    "wp": "https://en.wikipedia.org/wiki/{}",
}

c.completion.shrink = True
c.completion.use_best_match = True

# =============================================================================
# Fonts
# =============================================================================

c.fonts.default_family = "JetBrainsMono Nerd Font"
c.fonts.default_size = "11pt"
c.fonts.completion.entry = "11pt JetBrainsMono Nerd Font"
c.fonts.completion.category = "bold 11pt JetBrainsMono Nerd Font"
c.fonts.statusbar = "11pt JetBrainsMono Nerd Font"
c.fonts.tabs.selected = "11pt JetBrainsMono Nerd Font"
c.fonts.tabs.unselected = "11pt JetBrainsMono Nerd Font"
c.fonts.hints = "bold 11pt JetBrainsMono Nerd Font"

# =============================================================================
# Catppuccin Mocha Theme
# =============================================================================

# Palette
rosewater = "#f5e0dc"
flamingo  = "#f2cdcd"
pink      = "#f38ba8"
mauve     = "#cba6f7"
red       = "#f38ba8"
maroon    = "#eba0ac"
peach     = "#fab387"
yellow    = "#f9e2af"
green     = "#a6e3a1"
teal      = "#94e2d5"
sky       = "#89dceb"
sapphire  = "#74c7ec"
blue      = "#89b4fa"
lavender  = "#b4befe"
text      = "#cdd6f4"
subtext1  = "#bac2de"
subtext0  = "#a6adc8"
overlay2  = "#9399b2"
overlay1  = "#7f849c"
overlay0  = "#6c7086"
surface2  = "#585b70"
surface1  = "#45475a"
surface0  = "#313244"
base      = "#1e1e2e"
mantle    = "#181825"
crust     = "#11111b"

# Completion
c.colors.completion.fg = text
c.colors.completion.odd.bg = base
c.colors.completion.even.bg = mantle
c.colors.completion.category.fg = blue
c.colors.completion.category.bg = crust
c.colors.completion.category.border.top = crust
c.colors.completion.category.border.bottom = crust
c.colors.completion.item.selected.fg = text
c.colors.completion.item.selected.bg = surface1
c.colors.completion.item.selected.border.top = surface1
c.colors.completion.item.selected.border.bottom = surface1
c.colors.completion.item.selected.match.fg = blue
c.colors.completion.match.fg = blue
c.colors.completion.scrollbar.fg = overlay0
c.colors.completion.scrollbar.bg = base

# Context menu
c.colors.contextmenu.disabled.bg = surface1
c.colors.contextmenu.disabled.fg = overlay0
c.colors.contextmenu.menu.bg = base
c.colors.contextmenu.menu.fg = text
c.colors.contextmenu.selected.bg = surface1
c.colors.contextmenu.selected.fg = text

# Downloads
c.colors.downloads.bar.bg = crust
c.colors.downloads.error.bg = red
c.colors.downloads.error.fg = crust
c.colors.downloads.start.bg = blue
c.colors.downloads.start.fg = crust
c.colors.downloads.stop.bg = teal
c.colors.downloads.stop.fg = crust
c.colors.downloads.system.bg = "none"
c.colors.downloads.system.fg = "none"

# Hints
c.colors.hints.bg = peach
c.colors.hints.fg = crust
c.colors.hints.match.fg = surface0
c.hints.border = "1px solid " + mantle
c.hints.radius = 3

# Keyhint
c.colors.keyhint.bg = base
c.colors.keyhint.fg = text
c.colors.keyhint.suffix.fg = mauve

# Messages
c.colors.messages.error.bg = red
c.colors.messages.error.border = red
c.colors.messages.error.fg = crust
c.colors.messages.info.bg = base
c.colors.messages.info.border = base
c.colors.messages.info.fg = text
c.colors.messages.warning.bg = peach
c.colors.messages.warning.border = peach
c.colors.messages.warning.fg = crust

# Prompts
c.colors.prompts.bg = surface0
c.colors.prompts.border = "1px solid " + surface1
c.colors.prompts.fg = text
c.colors.prompts.selected.bg = surface1
c.colors.prompts.selected.fg = text

# Statusbar
c.colors.statusbar.caret.bg = mauve
c.colors.statusbar.caret.fg = crust
c.colors.statusbar.caret.selection.bg = mauve
c.colors.statusbar.caret.selection.fg = crust
c.colors.statusbar.command.bg = mantle
c.colors.statusbar.command.fg = text
c.colors.statusbar.command.private.bg = mantle
c.colors.statusbar.command.private.fg = mauve
c.colors.statusbar.insert.bg = teal
c.colors.statusbar.insert.fg = crust
c.colors.statusbar.normal.bg = base
c.colors.statusbar.normal.fg = text
c.colors.statusbar.passthrough.bg = sky
c.colors.statusbar.passthrough.fg = crust
c.colors.statusbar.private.bg = surface0
c.colors.statusbar.private.fg = text
c.colors.statusbar.progress.bg = blue
c.colors.statusbar.url.error.fg = red
c.colors.statusbar.url.fg = text
c.colors.statusbar.url.hover.fg = sky
c.colors.statusbar.url.success.http.fg = peach
c.colors.statusbar.url.success.https.fg = green
c.colors.statusbar.url.warn.fg = yellow

# Tabs
c.colors.tabs.bar.bg = crust
c.colors.tabs.even.bg = mantle
c.colors.tabs.even.fg = subtext0
c.colors.tabs.odd.bg = mantle
c.colors.tabs.odd.fg = subtext0
c.colors.tabs.selected.even.bg = base
c.colors.tabs.selected.even.fg = text
c.colors.tabs.selected.odd.bg = base
c.colors.tabs.selected.odd.fg = text
c.colors.tabs.pinned.even.bg = surface0
c.colors.tabs.pinned.even.fg = subtext0
c.colors.tabs.pinned.odd.bg = surface0
c.colors.tabs.pinned.odd.fg = subtext0
c.colors.tabs.pinned.selected.even.bg = base
c.colors.tabs.pinned.selected.even.fg = text
c.colors.tabs.pinned.selected.odd.bg = base
c.colors.tabs.pinned.selected.odd.fg = text
c.colors.tabs.indicator.error = red
c.colors.tabs.indicator.start = blue
c.colors.tabs.indicator.stop = teal
c.colors.tabs.indicator.system = "none"

# Webpage
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"
c.colors.webpage.bg = base

# =============================================================================
# Keybindings
# =============================================================================

# Clear defaults we'll override
config.unbind("d")
config.unbind("u")
config.unbind("co")
config.unbind("H")
config.unbind("L")

# Navigation
config.bind("H", "back")
config.bind("L", "forward")
config.bind("J", "tab-prev")
config.bind("K", "tab-next")
config.bind("d", "tab-close")
config.bind("u", "undo")
config.bind("D", "tab-close -o")  # close + reopen on undo

# Scrolling (already vim-like by default, reinforce)
config.bind("gg", "scroll-to-perc 0")
config.bind("G", "scroll-to-perc")
config.bind("<Ctrl-d>", "scroll-page 0 0.5")
config.bind("<Ctrl-u>", "scroll-page 0 -0.5")

# Tabs
config.bind("t", "open -t")
config.bind("T", "open -t {url}")  # duplicate tab
config.bind("<Alt-1>", "tab-focus 1")
config.bind("<Alt-2>", "tab-focus 2")
config.bind("<Alt-3>", "tab-focus 3")
config.bind("<Alt-4>", "tab-focus 4")
config.bind("<Alt-5>", "tab-focus 5")
config.bind("<Alt-6>", "tab-focus 6")
config.bind("<Alt-7>", "tab-focus 7")
config.bind("<Alt-8>", "tab-focus 8")
config.bind("<Alt-9>", "tab-focus -1")
config.bind("<Ctrl-Shift-h>", "tab-move -")
config.bind("<Ctrl-Shift-l>", "tab-move +")

# Quick open
config.bind("o", "cmd-set-text -s :open")
config.bind("O", "cmd-set-text -s :open -t")
config.bind("go", "cmd-set-text :open {url}")
config.bind("gO", "cmd-set-text :open -t {url}")

# Search engines quick access
config.bind(",y", "cmd-set-text -s :open yt ")
config.bind(",n", "cmd-set-text -s :open nix ")
config.bind(",N", "cmd-set-text -s :open nixo ")
config.bind(",m", "cmd-set-text -s :open mdn ")
config.bind(",w", "cmd-set-text -s :open wp ")

# Downloads
config.bind(",d", "download-clear")

# Config
config.bind(",r", "config-source")
config.bind(",e", "cmd-set-text :edit-file " + str(config.configdir) + "/config.py")

# Misc
config.bind(".", "cmd-repeat-last")
config.bind("<Ctrl-a>", "zoom-in")
config.bind("<Ctrl-x>", "zoom-out")
config.bind("<Ctrl-0>", "zoom")  # reset zoom
config.bind("yy", "yank")
config.bind("yY", "yank -s")  # selection
config.bind("yu", "yank url")
config.bind("yt", "yank title")
config.bind("pp", "open -- {clipboard}")
config.bind("pP", "open -t -- {clipboard}")

# Hint modes
config.bind("f", "hint")
config.bind("F", "hint all tab")
config.bind(";b", "hint all tab-bg")
config.bind(";d", "hint links download")
config.bind(";y", "hint links yank")
config.bind(";i", "hint images")

# Reader / print
config.bind("gr", "cmd-set-text :view-source")

# Insert mode passthrough toggle
config.bind("<Escape>", "mode-leave", mode="insert")
config.bind("<Ctrl-e>", "open-editor", mode="insert")
