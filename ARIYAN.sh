#!/data/data/com.termux/files/usr/bin/bash

# ══════════════════════════════════════════════
#        ARIYAN FREE FIRE - TERMUX SETUP
#        একদম নতুন ফোনে A to Z সেটআপ
# ══════════════════════════════════════════════

RESET="\033[0m"
BOLD="\033[1m"
GREEN="\033[92m"
YELLOW="\033[93m"
CYAN="\033[96m"
RED="\033[91m"
BLUE="\033[94m"
MAGENTA="\033[95m"
WHITE="\033[97m"
ORANGE="\033[38;5;214m"
DIM="\033[2m"

ok()   { echo -e "${GREEN}${BOLD}  [✔] $1${RESET}"; }
info() { echo -e "${CYAN}${BOLD}  [*] $1${RESET}"; }
warn() { echo -e "${YELLOW}${BOLD}  [!] $1${RESET}"; }
err()  { echo -e "${RED}${BOLD}  [✗] $1${RESET}"; }
line() { echo -e "${BLUE}${BOLD}  ══════════════════════════════════════${RESET}"; }

# ══════════════════════════════════════════════
# FREE FIRE লোগো (main.py থেকে হুবহু)
# ══════════════════════════════════════════════
FF_LINES=(
    "            ⣀⣠⡤                        "
    "   ⢀⣤⡶⠁⣠⣴⣾⠟⠋⠁                          "
    "  ⢀⣴⣿⣿⣴⣿⠿⠋⣁⣀⣀⣀⣀⣀⡀                      "
    "  ⣰⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⡀                "
    "⣠⣾⣿⡿⠟⠋⠉⠀⣀⣀⣨⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣤⣴⠂"
    "⠈⠉⠁⠀⣀⣴⣾⣿⣿⡿⠟⠛⠉⠉⠉⠉⠛⠻⠿⠿⠿⠿⠿⠿⠟⠋⠁          "
    "   ⢀⣴⣿⣿⣿⡿⠁⢀⣀⣤⣤⣤⣤⣀⣀                      "
    "   ⣾⣿⣿⣿⡿⠁⢀⣴⣿⠋⠉⠉⠉⠉⠛⣿⣿⣶⣤⣤⣤⣤⣶⠖            "
    "  ⢸⣿⣿⣿⣿⡇⢀⣿⣿⣇⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⡿⠃              "
    "  ⠸⣿⣿⣿⣿⡇⠈⢿⣿⣿⠇⠀⠀⠀⠀⢠⣿⣿⣿⠟⠋                "
    "   ⢿⣿⣿⣿⣷⡀⠀⠉⠉⠀⠀⠀⢀⣾⣿⣿⡏                    "
    "    ⠙⢿⣿⣿⣷⣄⡀⠀⠀⣀⣴⣿⣿⣿⣋⣠⡤⠄                  "
    "       ⠈⠙⠛⠛⠿⠿⠿⠿⠿⠟⠛⠛⠛⠉⠁                   "
)

FLASH_C=(
    "$RED" "$ORANGE" "$YELLOW" "$WHITE" "$ORANGE"
    "$RED" "$YELLOW" "$ORANGE" "$WHITE" "$RED"
    "$YELLOW" "$ORANGE" "$RED"
)

# FF লোগো প্রিন্ট (offset ও dim মোড)
print_ff() {
    local offset=${1:-0}
    local dim=${2:-0}
    echo -e "${CYAN}${BOLD}  ░█████╗░██████╗░██╗██╗░██╗░░█████╗░███╗░██╗${RESET}"
    echo ""
    local i
    for i in $(seq 0 12); do
        local ci=$(( (i + offset) % 13 ))
        local c="${FLASH_C[$ci]}"
        if [ "$dim" -eq 1 ] && [ $(( i % 2 )) -ne 0 ]; then
            echo -e "  ${RED}${DIM}${FF_LINES[$i]}${RESET}"
        else
            echo -e "  ${c}${BOLD}${FF_LINES[$i]}${RESET}"
        fi
    done
    echo ""
}

# ══════════════════════════════════════════════
# লাইটিং অ্যানিমেশন ফাংশন
# মডিউল ইন্সটলের সময় উপরে FF লোগো ফ্ল্যাশ করবে
# নিচে ইন্সটল স্ট্যাটাস দেখাবে
# ══════════════════════════════════════════════
ANIM_PID=""

start_anim() {
    touch /tmp/_ff_anim_on
    (
        local offset=0
        while [ -f /tmp/_ff_anim_on ]; do
            tput cup 0 0 2>/dev/null
            local mode=$(( offset % 3 ))
            if [ "$mode" -eq 2 ]; then
                print_ff "$offset" 1
            else
                print_ff "$offset" 0
            fi
            offset=$(( offset + 1 ))
            sleep 0.16
        done
    ) &
    ANIM_PID=$!
}

stop_anim() {
    rm -f /tmp/_ff_anim_on 2>/dev/null
    [ -n "$ANIM_PID" ] && kill "$ANIM_PID" 2>/dev/null && wait "$ANIM_PID" 2>/dev/null
    ANIM_PID=""
}

# লগ লাইন: অ্যানিমেশনের নিচে (সারি 18 থেকে)
STATUS_ROW=18
print_status() {
    tput cup $STATUS_ROW 0 2>/dev/null
    tput el 2>/dev/null
    echo -ne "  $1"
}

# ══════════════════════════════════════════════
# ধাপ ১: স্টোরেজ পারমিশন
# ══════════════════════════════════════════════
clear
info "স্টোরেজ পারমিশন চেক করা হচ্ছে..."
if [ ! -d ~/storage ]; then
    warn "পারমিশন দেওয়া হচ্ছে..."
    termux-setup-storage
    sleep 2
fi
ok "স্টোরেজ পারমিশন ঠিক আছে"
echo ""

# ══════════════════════════════════════════════
# ধাপ ২: pkg আপডেট
# ══════════════════════════════════════════════
line
info "Termux প্যাকেজ আপডেট করা হচ্ছে..."
line
pkg update -y 2>/dev/null || warn "pkg update এ সমস্যা, চালিয়ে যাচ্ছি..."
pkg upgrade -y 2>/dev/null
ok "প্যাকেজ আপডেট সম্পন্ন"
echo ""

# ══════════════════════════════════════════════
# ধাপ ৩: Python ইন্সটল
# ══════════════════════════════════════════════
line
info "Python চেক করা হচ্ছে..."
if command -v python3 &>/dev/null; then
    ok "Python আছে: $(python3 --version)"
else
    warn "Python নেই, ইন্সটল হচ্ছে..."
    pkg install python -y
    command -v python3 &>/dev/null || { err "Python ইন্সটল ব্যর্থ!"; exit 1; }
    ok "Python ইন্সটল সফল: $(python3 --version)"
fi
echo ""

# ══════════════════════════════════════════════
# ধাপ ৪: pip আপগ্রেড
# ══════════════════════════════════════════════
info "pip আপগ্রেড হচ্ছে..."
python3 -m pip install --upgrade pip -q 2>/dev/null
ok "pip আপগ্রেড সম্পন্ন"
echo ""

# ══════════════════════════════════════════════
# ধাপ ৫: Git ইন্সটল
# ══════════════════════════════════════════════
line
info "Git চেক করা হচ্ছে..."
if command -v git &>/dev/null; then
    ok "Git আছে: $(git --version)"
else
    pkg install git -y
    command -v git &>/dev/null || { err "Git ইন্সটল ব্যর্থ!"; exit 1; }
    ok "Git ইন্সটল সফল"
fi
echo ""

# ══════════════════════════════════════════════
# ধাপ ৬–৭: মডিউল ইন্সটল — FF লোগো লাইটিং সহ
# ══════════════════════════════════════════════
clear
# অ্যানিমেশন শুরু
start_anim
sleep 0.4

FAILED=()
TOTAL=11
DONE=0

install_mod_pip() {
    local name="$1"
    DONE=$(( DONE + 1 ))
    print_status "${CYAN}${BOLD}[$DONE/$TOTAL] $name ইন্সটল হচ্ছে...${RESET}"
    python3 -m pip install "$name" -q &>/dev/null
    if [ $? -eq 0 ]; then
        print_status "${GREEN}${BOLD}[$DONE/$TOTAL] ✔ $name${RESET}"
    else
        print_status "${RED}${BOLD}[$DONE/$TOTAL] ✗ $name ব্যর্থ!${RESET}"
        FAILED+=("$name")
    fi
    sleep 0.3
}

# pkg মডিউল
DONE=$(( DONE + 1 ))
print_status "${CYAN}${BOLD}[$DONE/$TOTAL] python-psutil (pkg) ইন্সটল হচ্ছে...${RESET}"
pkg install python-psutil -y &>/dev/null
if [ $? -eq 0 ]; then
    print_status "${GREEN}${BOLD}[$DONE/$TOTAL] ✔ python-psutil${RESET}"
else
    python3 -m pip install psutil -q &>/dev/null
    [ $? -eq 0 ] && print_status "${GREEN}${BOLD}[$DONE/$TOTAL] ✔ psutil (pip)${RESET}" \
                 || { print_status "${RED}${BOLD}[$DONE/$TOTAL] ✗ psutil ব্যর্থ!${RESET}"; FAILED+=("psutil"); }
fi
sleep 0.3

# pip মডিউল
install_mod_pip "requests"
install_mod_pip "PyJWT"
install_mod_pip "urllib3"
install_mod_pip "aiohttp"
install_mod_pip "flask"
install_mod_pip "pycryptodome"
install_mod_pip "protobuf"
install_mod_pip "google-play-scraper"
install_mod_pip "pytz"
install_mod_pip "pyfiglet"

# অ্যানিমেশন বন্ধ
stop_anim
sleep 0.2

# ══════════════════════════════════════════════
# ধাপ ৮: ফাইনাল রিপোর্ট
# ══════════════════════════════════════════════
clear
print_ff 4 0
line
if [ ${#FAILED[@]} -gt 0 ]; then
    warn "নিচের মডিউলগুলো ইন্সটল হয়নি:"
    for f in "${FAILED[@]}"; do
        echo -e "  ${RED}  ✗ $f${RESET}"
    done
    echo ""
    warn "ইন্টারনেট চেক করে আবার চালান।"
else
    echo -e "${GREEN}${BOLD}  🎉 সব মডিউল সফলভাবে ইন্সটল হয়েছে!${RESET}"
fi
line
echo ""

# ══════════════════════════════════════════════
# ধাপ ৯: GitHub Repo ক্লোন করে main.py রান
# ══════════════════════════════════════════════

# ⬇️ এখানে আপনার GitHub repo লিংক বসান
REPO_URL="https://github.com/Ariyan20267/New-update-bot.git"
REPO_DIR="$HOME/$(basename "$REPO_URL" .git)"

info "GitHub থেকে repo ক্লোন হচ্ছে..."
info "লিংক: $REPO_URL"
echo ""

# আগে থেকে ফোল্ডার থাকলে আপডেট, না থাকলে ক্লোন
if [ -d "$REPO_DIR/.git" ]; then
    warn "ফোল্ডার আগে থেকেই আছে, আপডেট করা হচ্ছে..."
    git -C "$REPO_DIR" pull 2>/dev/null
    ok "Repo আপডেট সম্পন্ন"
else
    git clone "$REPO_URL" "$REPO_DIR" 2>/dev/null
    if [ $? -eq 0 ]; then
        ok "Repo ক্লোন সম্পন্ন: $REPO_DIR"
    else
        err "Repo ক্লোন ব্যর্থ! repo লিংক চেক করুন।"
        exit 1
    fi
fi

echo ""

# main.py খোঁজা
MAIN_PATH="$REPO_DIR/main.py"

if [ -f "$MAIN_PATH" ]; then
    ok "main.py পাওয়া গেছে"
    echo ""
    line
    echo -e "${GREEN}${BOLD}  সব সেটআপ সম্পন্ন! main.py চালু হচ্ছে...${RESET}"
    line
    echo ""
    sleep 1
    cd "$REPO_DIR" && python3 main.py
else
    err "main.py পাওয়া যায়নি repo-তে!"
    warn "নিজে চালান: python3 $MAIN_PATH"
fi
