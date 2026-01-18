import os
from urllib.request import urlopen

# 1. Basics
config.load_autoconfig()

# 2. Layout (Hyprland Aesthetic)
c.tabs.position = "right"
c.tabs.width = "15%"
c.statusbar.show = "in-mode"
c.window.title_format = "{current_title}" # Cleaner window title

# 3. Apple Music Fix (User Agent & Autoplay)
# This allows Apple Music to load and play immediately
c.content.headers.user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36"
c.content.autoplay = True

# 4. Search Engines (DuckDuckGo Default)
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'am':      'https://music.apple.com/search?term={}',
    'nx':      'https://search.nixos.org/packages?query={}',
    'yt':      'https://www.youtube.com/results?search_query={}'
}

# 5. Quick-Link Aliases
# Type ':am' or ':yt' in the command bar to go straight to the site
c.aliases['am'] = 'open https://music.apple.com'
c.aliases['yt'] = 'open https://www.youtube.com'
c.aliases['nx'] = 'open https://search.nixos.org/packages'

# 6. Keybindings
config.bind('tt', 'config-cycle tabs.show always switching') # Toggle tab bar
config.bind('ga', 'open https://music.apple.com')            # 'ga' for Go Apple
config.bind('gn', 'open https://search.nixos.org/packages')  # 'gn' for Go Nix

# 7. Catppuccin Theme Loader
# This will download the theme setup automatically on the first run
theme_path = config.configdir / "theme.py"
if not os.path.exists(theme_path):
    try:
        theme_url = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
        with urlopen(theme_url) as response:
            with open(theme_path, "w") as f:
                f.write(response.read().decode("utf-8"))
    except Exception as e:
        print(f"Could not download theme: {e}")

if os.path.exists(theme_path):
    import theme
    # Options: 'latte', 'frappe', 'macchiato', 'mocha'
    theme.setup(c, 'mocha', True)

# Force Dark Mode on all websites
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.enabled = True
