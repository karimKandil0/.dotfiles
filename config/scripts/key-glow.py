import tinytuya
import time
import threading
import os
import colorsys
import sys
from evdev import InputDevice, ecodes

# Device Configuration
DEVICE_ID = 'bffb3ff22c28ecd701j0eq'
IP_ADDRESS = '192.168.1.170'
LOCAL_KEY = 'sv0@{2m=Am~Y-=M@'
KEYBOARD_PATH = '/dev/input/event3' 
WAL_CACHE = '/home/karimkandil/.cache/wal/colors'

# Operational Parameters
MAX_BRIGHT = 300   
MIN_BRIGHT = 15    
SEND_INTERVAL = 0.20 
DECAY_THRESHOLD = 0.4
TOGGLE_KEY = ecodes.KEY_F12 # Change this to your preferred key

def get_pywal_color():
    try:
        if not os.path.exists(WAL_CACHE):
            return 180, 1000, 1000 
        with open(WAL_CACHE, 'r') as f:
            colors = f.readlines()
        hex_color = colors[4].strip().lstrip('#')
        r, g, b = [int(hex_color[i:i+2], 16) for i in (0, 2, 4)]
        h, s, v = colorsys.rgb_to_hsv(r/255.0, g/255.0, b/255.0)
        return int(h * 360), int(s * 1000), 1000
    except Exception:
        return 180, 1000, 1000

def hsv_to_hex(h, s, v):
    return "{:04x}{:04x}{:04x}".format(int(h % 360), int(s), int(v))

class LightingController:
    def __init__(self):
        self.bulb = tinytuya.BulbDevice(DEVICE_ID, IP_ADDRESS, LOCAL_KEY)
        self.bulb.set_version(3.5)
        self.bulb.set_socketPersistent(False)
        self.last_press_time = 0
        self.last_sent_time = 0
        self.is_bright = False
        self.is_enabled = True # Operational state toggle
        self.hue, self.sat, _ = get_pywal_color()

    def toggle_power(self):
        self.is_enabled = not self.is_enabled
        if not self.is_enabled:
            # Immediate shutdown command
            self.bulb.send(self.bulb.generate_payload(tinytuya.CONTROL, {'20': False}))
        else:
            # Immediate restore command
            self.bulb.send(self.bulb.generate_payload(tinytuya.CONTROL, {'20': True, '21': 'colour'}))
        print(f"System State: {'ENABLED' if self.is_enabled else 'DISABLED'}")

    def update_bulb(self):
        last_mtime = 0
        while True:
            if not self.is_enabled:
                time.sleep(0.5)
                continue

            now = time.time()
            try:
                if os.path.exists(WAL_CACHE):
                    current_mtime = os.path.getmtime(WAL_CACHE)
                    if current_mtime > last_mtime:
                        self.hue, self.sat, _ = get_pywal_color()
                        last_mtime = current_mtime

                if now - self.last_press_time < DECAY_THRESHOLD:
                    if not self.is_bright or (now - self.last_sent_time > SEND_INTERVAL):
                        payload_hex = hsv_to_hex(self.hue, self.sat, MAX_BRIGHT)
                        self.bulb.send(self.bulb.generate_payload(tinytuya.CONTROL, {'24': payload_hex}))
                        self.is_bright = True
                        self.last_sent_time = now
                elif self.is_bright:
                    if now - self.last_sent_time > SEND_INTERVAL:
                        payload_hex = hsv_to_hex(self.hue, self.sat, MIN_BRIGHT)
                        self.bulb.send(self.bulb.generate_payload(tinytuya.CONTROL, {'24': payload_hex}))
                        self.is_bright = False
                        self.last_sent_time = now
            except Exception:
                time.sleep(2.0)
            time.sleep(0.05)

    def run(self):
        try:
            dev = InputDevice(KEYBOARD_PATH)
            self.bulb.send(self.bulb.generate_payload(tinytuya.CONTROL, {'20': True, '21': 'colour'}))
            threading.Thread(target=self.update_bulb, daemon=True).start()
            
            for event in dev.read_loop():
                if event.type == ecodes.EV_KEY and event.value == 1:
                    if event.code == TOGGLE_KEY:
                        self.toggle_power()
                    elif self.is_enabled:
                        self.last_press_time = time.time()
        except Exception:
            sys.exit(1)

if __name__ == "__main__":
    controller = LightingController()
    controller.run()
