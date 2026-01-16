config.load_autoconfig()

### Layout ###
c.tabs.position = "right"
c.tabs.width = "15%"
c.statusbar.show = "in-mode"  # Only show bottom bar when typing commands

### Binds ###
config.bind('tt', 'config-cycle tabs.show always switching')

### Themes ###
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True

### UI Colors ###
c.colors.tabs.bar.bg = "#1a1b26"
c.colors.tabs.even.bg = "#1a1b26"
c.colors.tabs.odd.bg = "#1a1b26"
c.colors.tabs.selected.even.bg = "#7aa2f7"  # Tokyo Night Blue highlight
c.colors.tabs.selected.odd.bg = "#7aa2f7"
c.colors.statusbar.normal.bg = "#1a1b26"


### Apple Music ###
c.content.headers.user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36"
c.content.autoplay = True

### Search Engines ###
# 5. Search Engines
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'ddg':     'https://duckduckgo.com/?q={}',
    'am':      'https://music.apple.com/search?term={}',
    'nx':      'https://search.nixos.org/packages?query={}',
    'yt':      'https://www.youtube.com/results?search_query={}'
}
