import json
import os

config.load_autoconfig(False)

# =============================================================================
# Pywal colors
# =============================================================================

wal = os.path.expanduser("~/.cache/wal/colors.json")
with open(wal) as f:
    colors = json.load(f)

bg       = colors["special"]["background"]
fg       = colors["special"]["foreground"]
color0   = colors["colors"]["color0"]
color1   = colors["colors"]["color1"]
color2   = colors["colors"]["color2"]
color4   = colors["colors"]["color4"]
color7   = colors["colors"]["color7"]
color8   = colors["colors"]["color8"]

# =============================================================================
# General
# =============================================================================

c.auto_save.session = False
c.confirm_quit = ["downloads"]
c.downloads.remove_finished = 5000
c.editor.command = ["kitty", "-e", "nvim", "{}"]

c.scrolling.smooth = True
c.scrolling.bar = "never"

c.content.autoplay = False
c.content.blocking.enabled = True
c.content.blocking.method = "hosts"
c.content.javascript.clipboard = "access"
c.content.notifications.enabled = False
c.content.geolocation = False
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"
c.colors.webpage.bg = bg

c.tabs.show = "multiple"
c.tabs.position = "top"
c.tabs.last_close = "close"
c.tabs.mousewheel_switching = False
c.tabs.favicons.show = "never"
c.tabs.title.format = "{index}: {current_title}"
c.tabs.title.format_pinned = "{index}"

c.url.default_page = "about:blank"
c.url.start_pages = ["about:blank"]
c.url.searchengines = {
    "DEFAULT": "http://localhost:8888/search?q={}",
    "yt": "https://youtube.com/search?q={}",
    "gh": "https://github.com/search?q={}",
    "nix": "https://search.nixos.org/packages?query={}",
    "nixo": "https://search.nixos.org/options?query={}",
    "mdn": "https://developer.mozilla.org/en-US/search?q={}",
    "py": "https://docs.python.org/3/search.html?q={}",
    "wp": "https://en.wikipedia.org/wiki/{}",
}

c.completion.shrink = True
c.completion.use_best_match = True

# =============================================================================
# Fonts
# =============================================================================

font = "11pt JetBrainsMono Nerd Font"
c.fonts.default_family = "JetBrainsMono Nerd Font"
c.fonts.default_size = "11pt"
c.fonts.completion.entry = font
c.fonts.completion.category = "bold " + font
c.fonts.statusbar = font
c.fonts.tabs.selected = font
c.fonts.tabs.unselected = font
c.fonts.hints = "bold " + font

# =============================================================================
# Theme (pywal)
# =============================================================================

# Completion
c.colors.completion.fg = fg
c.colors.completion.odd.bg = bg
c.colors.completion.even.bg = color0
c.colors.completion.category.fg = color2
c.colors.completion.category.bg = color0
c.colors.completion.category.border.top = color0
c.colors.completion.category.border.bottom = color0
c.colors.completion.item.selected.fg = fg
c.colors.completion.item.selected.bg = color8
c.colors.completion.item.selected.border.top = color8
c.colors.completion.item.selected.border.bottom = color8
c.colors.completion.item.selected.match.fg = color2
c.colors.completion.match.fg = color2
c.colors.completion.scrollbar.fg = color8
c.colors.completion.scrollbar.bg = bg

# Statusbar
c.colors.statusbar.normal.bg = bg
c.colors.statusbar.normal.fg = fg
c.colors.statusbar.insert.bg = color2
c.colors.statusbar.insert.fg = bg
c.colors.statusbar.command.bg = color0
c.colors.statusbar.command.fg = fg
c.colors.statusbar.caret.bg = color1
c.colors.statusbar.caret.fg = bg
c.colors.statusbar.caret.selection.bg = color1
c.colors.statusbar.caret.selection.fg = bg
c.colors.statusbar.passthrough.bg = color4
c.colors.statusbar.passthrough.fg = bg
c.colors.statusbar.private.bg = color8
c.colors.statusbar.private.fg = fg
c.colors.statusbar.progress.bg = color2
c.colors.statusbar.url.fg = fg
c.colors.statusbar.url.hover.fg = color2
c.colors.statusbar.url.success.http.fg = color7
c.colors.statusbar.url.success.https.fg = color2
c.colors.statusbar.url.error.fg = color1
c.colors.statusbar.url.warn.fg = color4

# Tabs
c.colors.tabs.bar.bg = bg
c.colors.tabs.odd.bg = bg
c.colors.tabs.odd.fg = color8
c.colors.tabs.even.bg = bg
c.colors.tabs.even.fg = color8
c.colors.tabs.selected.odd.bg = color0
c.colors.tabs.selected.odd.fg = fg
c.colors.tabs.selected.even.bg = color0
c.colors.tabs.selected.even.fg = fg
c.colors.tabs.indicator.start = color2
c.colors.tabs.indicator.stop = color2
c.colors.tabs.indicator.error = color1
c.colors.tabs.indicator.system = "none"
c.colors.tabs.pinned.odd.bg = bg
c.colors.tabs.pinned.odd.fg = color8
c.colors.tabs.pinned.even.bg = bg
c.colors.tabs.pinned.even.fg = color8
c.colors.tabs.pinned.selected.odd.bg = color0
c.colors.tabs.pinned.selected.odd.fg = fg
c.colors.tabs.pinned.selected.even.bg = color0
c.colors.tabs.pinned.selected.even.fg = fg

# Hints
c.colors.hints.bg = color1
c.colors.hints.fg = bg
c.colors.hints.match.fg = color8
c.hints.border = "1px solid " + color0
c.hints.radius = 2

# Messages
c.colors.messages.error.bg = color1
c.colors.messages.error.border = color1
c.colors.messages.error.fg = bg
c.colors.messages.info.bg = color0
c.colors.messages.info.border = color0
c.colors.messages.info.fg = fg
c.colors.messages.warning.bg = color4
c.colors.messages.warning.border = color4
c.colors.messages.warning.fg = bg

# Prompts
c.colors.prompts.bg = color0
c.colors.prompts.border = "1px solid " + color8
c.colors.prompts.fg = fg
c.colors.prompts.selected.bg = color8
c.colors.prompts.selected.fg = fg

# Keyhint
c.colors.keyhint.bg = color0
c.colors.keyhint.fg = fg
c.colors.keyhint.suffix.fg = color2

# Downloads
c.colors.downloads.bar.bg = bg
c.colors.downloads.start.bg = color2
c.colors.downloads.start.fg = bg
c.colors.downloads.stop.bg = color2
c.colors.downloads.stop.fg = bg
c.colors.downloads.error.bg = color1
c.colors.downloads.error.fg = bg
c.colors.downloads.system.bg = "none"
c.colors.downloads.system.fg = "none"

# Context menu
c.colors.contextmenu.menu.bg = color0
c.colors.contextmenu.menu.fg = fg
c.colors.contextmenu.selected.bg = color8
c.colors.contextmenu.selected.fg = fg
c.colors.contextmenu.disabled.bg = color0
c.colors.contextmenu.disabled.fg = color8

# =============================================================================
# Keybindings
# =============================================================================

config.unbind("d")
config.unbind("u")
config.unbind("H")
config.unbind("L")
config.unbind("co")

config.bind("H", "back")
config.bind("L", "forward")
config.bind("J", "tab-prev")
config.bind("K", "tab-next")
config.bind("d", "tab-close")
config.bind("u", "undo")
config.bind("t", "open -t")
config.bind("T", "open -t {url}")

config.bind("o", "cmd-set-text -s :open")
config.bind("O", "cmd-set-text -s :open -t")
config.bind("go", "cmd-set-text :open {url}")
config.bind("gO", "cmd-set-text :open -t {url}")

config.bind("gg", "scroll-to-perc 0")
config.bind("G", "scroll-to-perc")
config.bind("<Ctrl-d>", "scroll-page 0 0.5")
config.bind("<Ctrl-u>", "scroll-page 0 -0.5")

config.bind("f", "hint")
config.bind("F", "hint all tab")
config.bind(";b", "hint all tab-bg")
config.bind(";d", "hint links download")
config.bind(";y", "hint links yank")

config.bind("yy", "yank")
config.bind("yu", "yank url")
config.bind("yt", "yank title")
config.bind("pp", "open -- {clipboard}")
config.bind("pP", "open -t -- {clipboard}")

config.bind("<Alt-1>", "tab-focus 1")
config.bind("<Alt-2>", "tab-focus 2")
config.bind("<Alt-3>", "tab-focus 3")
config.bind("<Alt-4>", "tab-focus 4")
config.bind("<Alt-5>", "tab-focus 5")
config.bind("<Alt-6>", "tab-focus 6")
config.bind("<Alt-7>", "tab-focus 7")
config.bind("<Alt-8>", "tab-focus 8")
config.bind("<Alt-9>", "tab-focus -1")

config.bind(",r", "config-source")
config.bind(",e", "cmd-set-text :edit-file " + str(config.configdir) + "/config.py")
config.bind(",d", "download-clear")
config.bind(".", "cmd-repeat-last")

config.bind("<Escape>", "mode-leave", mode="insert")
config.bind("<Ctrl-e>", "open-editor", mode="insert")
