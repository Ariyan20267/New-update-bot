import time
import os
import sys
import threading
import subprocess
import importlib

# ── কালার কোড ────────────────────────────────────────────────
RESET   = "\033[0m"
BOLD    = "\033[1m"
GREEN   = "\033[92m"
YELLOW  = "\033[93m"
MAGENTA = "\033[95m"
CYAN    = "\033[96m"
RED     = "\033[91m"
BLUE    = "\033[94m"
WHITE   = "\033[97m"
ORANGE  = "\033[38;5;214m"
DIM     = "\033[2m"

def clear():
    os.system("clear")

# ── মোটা ASCII আর্ট — ARIYAN ─────────────────────────────────
LETTERS = {
    'A': [
        "  █████╗  ",
        " ██╔══██╗ ",
        " ███████║ ",
        " ██╔══██║ ",
        " ██║  ██║ ",
        " ╚═╝  ╚═╝ ",
    ],
    'R': [
        " ██████╗  ",
        " ██╔══██╗ ",
        " ██████╔╝ ",
        " ██╔══██╗ ",
        " ██║  ██║ ",
        " ╚═╝  ╚═╝ ",
    ],
    'I': [
        " ██╗ ",
        " ██║ ",
        " ██║ ",
        " ██║ ",
        " ██║ ",
        " ╚═╝ ",
    ],
    'Y': [
        " ██╗   ██╗ ",
        " ╚██╗ ██╔╝ ",
        "  ╚████╔╝  ",
        "   ╚██╔╝   ",
        "    ██║    ",
        "    ╚═╝    ",
    ],
    'A2': [
        "  █████╗  ",
        " ██╔══██╗ ",
        " ███████║ ",
        " ██╔══██║ ",
        " ██║  ██║ ",
        " ╚═╝  ╚═╝ ",
    ],
    'N': [
        " ███╗   ██╗ ",
        " ████╗  ██║ ",
        " ██╔██╗ ██║ ",
        " ██║╚██╗██║ ",
        " ██║ ╚████║ ",
        " ╚═╝  ╚═══╝ ",
    ],
}

LETTER_ORDER  = ['A', 'R', 'I', 'Y', 'A2', 'N']
LETTER_COLORS = [CYAN, RED, YELLOW, MAGENTA, GREEN, BLUE]
ROWS = 6

def get_lines(visible_count):
    lines = [""] * ROWS
    for i in range(visible_count):
        key   = LETTER_ORDER[i]
        color = LETTER_COLORS[i % len(LETTER_COLORS)]
        for row in range(ROWS):
            lines[row] += color + BOLD + LETTERS[key][row] + RESET
    return lines

def print_ariyan_static():
    for line in get_lines(6):
        print(" " + line)

# ── আসল Free Fire লোগো ───────────────────────────────────────
FF_LOGO = [
    "            ⣀⣠⡤                        ",
    "   ⢀⣤⡶⠁⣠⣴⣾⠟⠋⠁                          ",
    "  ⢀⣴⣿⣿⣴⣿⠿⠋⣁⣀⣀⣀⣀⣀⡀                      ",
    "  ⣰⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⡀                ",
    "⣠⣾⣿⡿⠟⠋⠉⠀⣀⣀⣨⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣤⣴⠂",
    "⠈⠉⠁⠀⣀⣴⣾⣿⣿⡿⠟⠛⠉⠉⠉⠉⠛⠻⠿⠿⠿⠿⠿⠿⠟⠋⠁          ",
    "   ⢀⣴⣿⣿⣿⡿⠁⢀⣀⣤⣤⣤⣤⣀⣀                      ",
    "   ⣾⣿⣿⣿⡿⠁⢀⣴⣿⠋⠉⠉⠉⠉⠛⣿⣿⣶⣤⣤⣤⣤⣶⠖            ",
    "  ⢸⣿⣿⣿⣿⡇⢀⣿⣿⣇⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⡿⠃              ",
    "  ⠸⣿⣿⣿⣿⡇⠈⢿⣿⣿⠇⠀⠀⠀⠀⢠⣿⣿⣿⠟⠋                ",
    "   ⢿⣿⣿⣿⣷⡀⠀⠉⠉⠀⠀⠀⢀⣾⣿⣿⡏                    ",
    "    ⠙⢿⣿⣿⣷⣄⡀⠀⠀⣀⣴⣿⣿⣿⣋⣠⡤⠄                  ",
    "       ⠈⠙⠛⠛⠿⠿⠿⠿⠿⠟⠛⠛⠛⠉⠁                   ",
]

FLASH_COLORS = [RED, ORANGE, YELLOW, WHITE, ORANGE, RED, YELLOW,
                ORANGE, WHITE, RED, YELLOW, ORANGE, RED]

def print_ff_logo(color_offset=0, dim_mode=False):
    for row, line in enumerate(FF_LOGO):
        c = FLASH_COLORS[(row + color_offset) % len(FLASH_COLORS)]
        if dim_mode and row % 2 != 0:
            print(RED + DIM + line + RESET)
        else:
            print(c + BOLD + line + RESET)

# ── ধাপ ১: ARIYAN দ্রুত ভেসে উঠবে ──────────────────────────
for i in range(1, 7):
    for flash in range(3):
        clear()
        print("\n")
        lines = get_lines(i) if flash % 2 == 0 else get_lines(i - 1)
        for line in lines:
            print(" " + line)
        print()
        time.sleep(0.06)
    clear()
    print("\n")
    for line in get_lines(i):
        print(" " + line)
    print()
    time.sleep(0.12)

time.sleep(0.4)

# ── ধাপ ২: Free Fire লোগো লাইটিং ────────────────────────────
for flash_round in range(10):
    clear()
    print("\n")
    print_ariyan_static()
    print()
    if flash_round % 3 == 0:
        for row, line in enumerate(FF_LOGO):
            c = [WHITE, YELLOW, ORANGE, RED][flash_round % 4]
            print(c + BOLD + line + RESET)
    elif flash_round % 3 == 1:
        print_ff_logo(color_offset=flash_round)
    else:
        print_ff_logo(dim_mode=True)
    print()
    time.sleep(0.16)

clear()
print("\n")
print_ariyan_static()
print()
print_ff_logo(color_offset=2)
print()
time.sleep(0.8)

# ── ধাপ ৩: WhatsApp ──────────────────────────────────────────
clear()
print()
wa_lines = [
    "  ╔══════════════════════════════════════════╗",
    "  ║                                          ║",
    "  ║   📱  WhatsApp গ্রুপে জয়েন হন!          ║",
    "  ║                                          ║",
    "  ║   🔗  লিংক খুলছে... অপেক্ষা করুন       ║",
    "  ║                                          ║",
    "  ╚══════════════════════════════════════════╝",
]
wa_colors = [GREEN, GREEN, YELLOW, GREEN, CYAN, GREEN, GREEN]
for i, line in enumerate(wa_lines):
    print(wa_colors[i] + BOLD + line + RESET)
    time.sleep(0.09)
print()
time.sleep(0.5)
os.system('am start -a android.intent.action.VIEW -d "https://chat.whatsapp.com/LMO2lqCnie7HRFL8pIKzAH?mode=gi_t"')
time.sleep(0.8)

# ── ধাপ ৪: মডিউল ইনস্টলার ───────────────────────────────────
# method: "pip"  → শুধু pip দিয়ে
# method: "pkg"  → শুধু pkg দিয়ে (psutil এর মতো)
MODULES = [
    ("requests",            "requests",            "pip"),
    ("psutil",              "psutil",              "pkg"),   # pkg install python-psutil
    ("PyJWT",               "jwt",                 "pip"),
    ("urllib3",             "urllib3",             "pip"),
    ("aiohttp",             "aiohttp",             "pip"),
    ("flask",               "flask",               "pip"),
    ("pycryptodome",        "Crypto",              "pip"),
    ("protobuf",            "google.protobuf",     "pip"),
    ("google-play-scraper", "google_play_scraper", "pip"),
    ("pytz",                "pytz",                "pip"),
]

# pkg install এর জন্য package name ম্যাপিং
PKG_NAMES = {
    "psutil": "python-psutil",
}

clear()
print()
print(CYAN + BOLD + "  ╔══════════════════════════════════════════════╗" + RESET)
print(CYAN + BOLD + "  ║       📦  মডিউল চেক করা হচ্ছে...           ║" + RESET)
print(CYAN + BOLD + "  ╚══════════════════════════════════════════════╝" + RESET)
print()
time.sleep(0.4)

BAR_LEN = 25

def run_progress_bar(stop_flag, label):
    spin    = ["⠋","⠙","⠹","⠸","⠼","⠴","⠦","⠧","⠇","⠏"]
    bcolors = [RED, ORANGE, YELLOW, GREEN, CYAN, MAGENTA]
    filled  = 0
    idx     = 0
    while not stop_flag.is_set():
        bc  = bcolors[filled % len(bcolors)]
        bar = bc + BOLD + "█" * filled + DIM + "░" * (BAR_LEN - filled) + RESET
        sp  = spin[idx % len(spin)]
        sys.stdout.write(f"\r  {YELLOW}↓{RESET}  {WHITE}{BOLD}{label:<24}{RESET}  [{bar}]  {CYAN}{sp}{RESET}  ")
        sys.stdout.flush()
        filled = min(filled + 1, BAR_LEN)
        idx   += 1
        time.sleep(0.07)

for pip_name, import_name, method in MODULES:
    # আগে থেকে আছে কিনা চেক
    try:
        importlib.import_module(import_name.split(".")[0])
        already = True
    except ImportError:
        already = False

    if already:
        bar = GREEN + BOLD + "█" * BAR_LEN + RESET
        print(f"  {GREEN}✔{RESET}  {WHITE}{BOLD}{pip_name:<24}{RESET}  [{bar}]  {GREEN}{BOLD}ALREADY INSTALLED ✓{RESET}")
        time.sleep(0.15)
        continue

    # ── ইনস্টল করো ───────────────────────────────────────────
    stop_flag = threading.Event()
    t = threading.Thread(target=run_progress_bar, args=(stop_flag, pip_name))
    t.start()

    if method == "pkg":
        pkg_pkg_name = PKG_NAMES.get(pip_name, pip_name)
        result = subprocess.run(
            ["pkg", "install", pkg_pkg_name, "-y"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )
    else:
        result = subprocess.run(
            [sys.executable, "-m", "pip", "install", pip_name, "-q"],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL
        )

    stop_flag.set()
    t.join()

    # ইনস্টল হলো কিনা যাচাই
    try:
        importlib.import_module(import_name.split(".")[0])
        success = True
    except ImportError:
        success = False

    if success:
        tag = "PKG INSTALLED ✓" if method == "pkg" else "INSTALLED ✓"
        bar = GREEN + BOLD + "█" * BAR_LEN + RESET
        sys.stdout.write(f"\r  {GREEN}✔{RESET}  {WHITE}{BOLD}{pip_name:<24}{RESET}  [{bar}]  {GREEN}{BOLD}{tag}{RESET}          \n")
    else:
        bar = RED + BOLD + "█" * BAR_LEN + RESET
        sys.stdout.write(f"\r  {RED}✘{RESET}  {WHITE}{BOLD}{pip_name:<24}{RESET}  [{bar}]  {RED}{BOLD}FAILED ✘{RESET}             \n")
    sys.stdout.flush()
    time.sleep(0.1)

print()
print(GREEN + BOLD + "  ✅  সব মডিউল প্রস্তুত! মূল প্রোগ্রাম শুরু হচ্ছে..." + RESET)
print()
time.sleep(1)
clear()

# ════════════════════════════════════════════════════════════
# ✅ এখান থেকে তোমার মূল কোড শুরু করো — সরাসরি paste করো
# ════════════════════════════════════════════════════════════
import os, sys, subprocess, threading, time, json, socket, shutil, importlib, re, logging, random

# ==========================================
# 1. CORE MODULE INSTALLER
# ==========================================
def install_and_import(pkg, mod=None):
    if mod is None: mod = pkg
    try:
        importlib.import_module(mod)
    except ImportError:
        subprocess.run([sys.executable, "-m", "pip", "install", pkg, "--quiet"], check=True)

check_modules = {'flask': 'flask', 'requests': 'requests', 'psutil': 'psutil', 'cfonts': 'cfonts'}
for p, m in check_modules.items(): install_and_import(p, m)

from flask import Flask, render_template_string, jsonify, request
import psutil
from cfonts import render

# ==========================================
# 2. CONFIGURATION
# ==========================================
CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
CONFIG_FILE = os.path.join(CURRENT_DIR, "ariyan_vip_pro.json")
GITHUB_REPO = "https://github.com/Ariyan20267/Ariyan_bot.git"

# ৪টি বোট কনফিগারেশন
bots = {
    "1": {"active": True, "uid": "", "pwd": "", "status": "Stopped", "process": None, "logs": [], "start_time": 0},
    "2": {"active": False, "uid": "", "pwd": "", "status": "Stopped", "process": None, "logs": [], "start_time": 0},
    "3": {"active": False, "uid": "", "pwd": "", "status": "Stopped", "process": None, "logs": [], "start_time": 0},
    "4": {"active": False, "uid": "", "pwd": "", "status": "Stopped", "process": None, "logs": [], "start_time": 0}
}

app = Flask(__name__)
logging.getLogger('werkzeug').setLevel(logging.ERROR)

def save_config():
    data = {k: {"uid": v["uid"], "pwd": v["pwd"], "active": v["active"]} for k, v in bots.items()}
    with open(CONFIG_FILE, 'w') as f: json.dump(data, f, indent=4)

def load_config():
    if os.path.exists(CONFIG_FILE):
        try:
            with open(CONFIG_FILE, 'r') as f:
                saved = json.load(f)
                for k in saved:
                    if k in bots: bots[k].update(saved[k])
        except: pass

# ==========================================
# 3. BOT ENGINE (OPTIMIZED)
# ==========================================
def run_bot_engine(bid):
    b = bots[bid]
    bot_dir = os.path.join(CURRENT_DIR, f"Ariyan_VIP_{bid}")
    
    # মেমোরি বাঁচাতে প্রতিবার ক্লোন না করে চেক করবে
    if not os.path.exists(bot_dir):
        b["logs"].append(f"🚀 [SYS] Initializing Server {bid}...")
        subprocess.run(["git", "clone", "--depth", "1", GITHUB_REPO, bot_dir], capture_output=True)
    
    while b["status"] == "Running":
        try:
            # আলাদা গেস্ট আইডি ফাইল তৈরি
            with open(os.path.join(bot_dir, "ARIYAN.txt"), 'w') as f:
                json.dump({b["uid"]: b["pwd"]}, f, indent=4)

            # বোট প্রসেস স্টার্ট
            b["process"] = subprocess.Popen(
                [sys.executable, "-u", "main.py"],
                cwd=bot_dir, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, bufsize=1
            )
            b["start_time"] = time.time()

            for line in iter(b["process"].stdout.readline, ''):
                if b["status"] != "Running": break
                if line.strip():
                    b["logs"].append(line.strip())
                    if len(b["logs"]) > 100: b["logs"].pop(0) # লগ লিমিট কমিয়ে মেমোরি সেভ
            
            b["process"].wait()
            if b["status"] == "Running":
                b["logs"].append("🔄 [SYS] Restarting in 5s...")
                time.sleep(5)
        except Exception as e:
            b["logs"].append(f"⚠️ [ERROR] {str(e)}")
            time.sleep(10)

def restart_scheduler():
    while True:
        time.sleep(60)
        for bid, b in bots.items():
            if b["status"] == "Running" and b["start_time"] > 0:
                # ২ ঘণ্টা পর অটো রিস্টার্ট
                if (time.time() - b["start_time"]) > 7200:
                    b["logs"].append("⚡ [SYSTEM] 2 Hours Limit! Auto-refreshing...")
                    if b["process"]: b["process"].kill()

threading.Thread(target=restart_scheduler, daemon=True).start()

# ==========================================
# 4. VIP HACKER UI (4 COLUMN SUPPORT)
# ==========================================
HTML_PAGE = r"""
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ARIYAN HACKER PANEL</title>
    <style>
        body, html { margin: 0; padding: 0; height: 100%; background: #000; font-family: 'Courier New', monospace; overflow-x: hidden; color: #0f0; }
        canvas { position: fixed; top: 0; left: 0; z-index: -1; }
        .container { position: relative; z-index: 10; padding: 20px; }
        .header { text-align: center; border: 2px solid #0f0; background: rgba(0, 20, 0, 0.8); padding: 15px; margin-bottom: 30px; box-shadow: 0 0 20px #0f0; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 15px; }
        .card { 
            background: rgba(0, 0, 0, 0.85); border: 2px solid #0f0; padding: 15px; border-radius: 10px; 
            position: relative; animation: slideUp 0.5s ease-out; box-shadow: 0 0 10px #004400;
        }
        @keyframes slideUp { from { opacity: 0; transform: translateY(30px); } to { opacity: 1; transform: translateY(0); } }
        .btn-rgb {
            width: 100%; padding: 10px; margin-top: 10px; border-radius: 5px; background: #000; color: #fff; 
            font-weight: bold; cursor: pointer; border: 2px solid transparent; position: relative; overflow: hidden; z-index: 1;
        }
        .btn-rgb::after {
            content: ''; position: absolute; top: -50%; left: -50%; width: 200%; height: 200%;
            background: conic-gradient(#ff0000, #48ff00, #002bff, #ff0000); animation: rotateRGB 4s linear infinite; z-index: -1;
        }
        .btn-rgb::before { content: ''; position: absolute; inset: 2px; background: #000; border-radius: 3px; z-index: -1; }
        @keyframes rotateRGB { 100% { transform: rotate(360deg); } }
        .btn-stop { border: 1px solid #f00 !important; color: #f00; margin-top: 5px; }
        .btn-stop::after { background: #500; animation: none; }
        input { width: 100%; padding: 8px; background: #000; border: 1px solid #0f0; color: #0f0; margin: 5px 0; box-sizing: border-box; }
        .terminal { height: 150px; background: rgba(0, 5, 0, 0.9); border: 1px solid #0a0; margin-top: 10px; padding: 8px; font-size: 10px; overflow-y: auto; color: #0f0; white-space: pre-wrap; }
        .fab { position: fixed; bottom: 20px; right: 20px; width: 50px; height: 50px; border-radius: 50%; background: #000; border: 2px solid #0f0; color: #0f0; font-size: 30px; cursor: pointer; z-index: 100; box-shadow: 0 0 15px #0f0; }
        .status-badge { float: right; font-size: 11px; border: 1px solid; padding: 1px 5px; }
    </style>
</head>
<body>
    <canvas id="matrix"></canvas>
    <div class="container">
        <div class="header">
            <h1 style="margin:0; font-size: 24px; letter-spacing: 5px;">ARIYAN VIP SYSTEM</h1>
            <div id="stats">CPU: 0% | RAM: 0% | ACTIVE: 0</div>
        </div>
        <div class="grid" id="card-container">
            {% for bid, b in bots.items() %}
                {% if b.active %}
                <div class="card">
                    <span class="status-badge" style="color:{{ '#0f0' if b.status=='Running' else '#f00' }}">{{ b.status }}</span>
                    <h4 style="margin:0">SERVER #{{ bid }}</h4>
                    <input type="text" id="uid-{{bid}}" placeholder="UID" value="{{ b.uid }}">
                    <input type="text" id="pwd-{{bid}}" placeholder="PASS" value="{{ b.pwd }}">
                    <button class="btn-rgb" onclick="control('{{bid}}', 'start')">START</button>
                    <button class="btn-rgb btn-stop" onclick="control('{{bid}}', 'stop')">STOP</button>
                    <div class="terminal" id="log-{{bid}}">Logs...</div>
                </div>
                {% endif %}
            {% endfor %}
        </div>
    </div>
    <button class="fab" onclick="addServer()">+</button>

    <script>
        const canvas = document.getElementById('matrix');
        const ctx = canvas.getContext('2d');
        canvas.width = window.innerWidth; canvas.height = window.innerHeight;
        const letters = "0101ABCDEF"; const fontSize = 15;
        const columns = canvas.width / fontSize;
        const drops = Array(Math.floor(columns)).fill(1);
        function drawMatrix() {
            ctx.fillStyle = "rgba(0, 0, 0, 0.05)"; ctx.fillRect(0, 0, canvas.width, canvas.height);
            ctx.fillStyle = "#0f0"; ctx.font = fontSize + "px monospace";
            for (let i = 0; i < drops.length; i++) {
                const text = letters.charAt(Math.floor(Math.random() * letters.length));
                ctx.fillText(text, i * fontSize, drops[i] * fontSize);
                if (drops[i] * fontSize > canvas.height && Math.random() > 0.975) drops[i] = 0;
                drops[i]++;
            }
        }
        setInterval(drawMatrix, 50);

        function control(bid, action) {
            const uid = document.getElementById('uid-'+bid).value;
            const pwd = document.getElementById('pwd-'+bid).value;
            fetch('/api/control', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({bid, action, uid, pwd})
            });
        }

        function addServer() {
            fetch('/api/add_server').then(r => r.json()).then(data => {
                if(data.success) location.reload();
                else alert("MAX 4 SERVERS REACHED");
            });
        }

        setInterval(() => {
            fetch('/api/stats').then(r => r.json()).then(data => {
                document.getElementById('stats').innerText = `CPU: ${data.cpu} | RAM: ${data.ram} | ACTIVE: ${data.active_count}`;
                for(let bid in data.bots) {
                    const l = document.getElementById('log-'+bid);
                    if(l) {
                        l.innerText = data.bots[bid].logs.join('\n');
                        l.scrollTop = l.scrollHeight;
                    }
                }
            });
        }, 2000);
    </script>
</body>
</html>
"""

# ==========================================
# 5. FLASK API ROUTES
# ==========================================
@app.route('/')
def index():
    load_config()
    active_count = sum(1 for b in bots.values() if b["active"])
    return render_template_string(HTML_PAGE, bots=bots, active_count=active_count)

@app.route('/api/add_server')
def add_server():
    active_count = sum(1 for b in bots.values() if b["active"])
    if active_count < 4: # ৪টি সার্ভার লিমিট
        for bid in ["1", "2", "3", "4"]:
            if not bots[bid]["active"]:
                bots[bid]["active"] = True
                save_config()
                return jsonify({"success": True})
    return jsonify({"success": False})

@app.route('/api/control', methods=['POST'])
def control():
    data = request.json
    bid, action = data.get('bid'), data.get('action')
    if bid in bots:
        bots[bid]["uid"], bots[bid]["pwd"] = data.get("uid", ""), data.get("pwd", "")
        save_config()
        if action == 'start' and bots[bid]["status"] != "Running":
            bots[bid]["status"] = "Running"
            threading.Thread(target=run_bot_engine, args=(bid,), daemon=True).start()
        elif action == 'stop':
            bots[bid]["status"] = "Stopped"
            if bots[bid]["process"]: 
                bots[bid]["process"].terminate() # Safely terminate
    return jsonify({"status": "ok"})

@app.route('/api/stats')
def stats():
    try: cpu = f"{psutil.cpu_percent()}%"
    except: cpu = "N/A"
    active_count = sum(1 for b in bots.values() if b["active"])
    return jsonify({
        "cpu": cpu, "ram": f"{psutil.virtual_memory().percent}%",
        "active_count": active_count,
        "bots": {bid: {"status": b["status"], "logs": b["logs"][-30:]} for bid, b in bots.items() if b["active"]}
    })

if __name__ == '__main__':
    load_config()
    os.system('clear' if os.name == 'posix' else 'cls')
    print(render('ARIYAN', colors=['cyan', 'yellow'], align='center'))
    PORT = 5000
    print(f"\033[1;32m[+] PRO PANEL LIVE: http://localhost:{PORT}\033[0m")
    app.run(host='0.0.0.0', port=PORT, debug=False, use_reloader=False)