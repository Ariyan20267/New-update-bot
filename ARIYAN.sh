#!/data/data/com.termux/files/usr/bin/bash

# ============================================================
#         ARIYAN LEVELUP BOT - TERMUX AUTO SETUP
# ============================================================

RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"
GREEN="\033[92m"
YELLOW="\033[93m"
CYAN="\033[96m"
RED="\033[91m"
BLUE="\033[94m"
WHITE="\033[97m"
ORANGE="\033[38;5;214m"
PINK="\033[38;5;206m"
PURPLE="\033[38;5;129m"

# আরিয়ান কালার প্যালেট
RGB=(
    "\033[38;5;196m"  # লাল
    "\033[38;5;208m"  # কমলা
    "\033[38;5;226m"  # হলুদ
    "\033[38;5;118m"  # গ্রিন
    "\033[38;5;51m"   # সায়ান
    "\033[38;5;45m"   # নীল
    "\033[38;5;93m"   # পার্পল
    "\033[38;5;201m"  # ম্যাজেন্টা
    "\033[38;5;198m"  # পিঙ্ক
    "\033[38;5;214m"  # অরেঞ্জ
    "\033[38;5;220m"  # সোনালী
    "\033[38;5;154m"  # চুন
    "\033[38;5;57m"   # ইন্ডিগো
    "\033[38;5;129m"  # ভায়োলেট
    "\033[38;5;212m"  # হট পিঙ্ক
)
RGB_LEN=15

FLASH=("$RED" "$ORANGE" "$YELLOW" "$WHITE" "$PINK" "$PURPLE" "$CYAN" "$GREEN" "$ORANGE" "$RED" "$YELLOW" "$PINK" "$PURPLE")

# ============================================================
# FREE FIRE LOGO (আরিয়ান ভার্সন)
# ============================================================
FF_L0="            ⣀⣠⡤                        "
FF_L1="   ⢀⣤⡶⠁⣠⣴⣾⠟⠋⠁                          "
FF_L2="  ⢀⣴⣿⣿⣴⣿⠿⠋⣁⣀⣀⣀⣀⣀⡀                      "
FF_L3="  ⣰⣿⣿⣿⣿⣿⣷⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣶⣄⡀                "
FF_L4="⣠⣾⣿⡿⠟⠋⠉⠀⣀⣀⣨⣭⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣤⣤⣤⣤⣴⠂"
FF_L5="⠈⠉⠁⠀⣀⣴⣾⣿⣿⡿⠟⠛⠉⠉⠉⠉⠛⠻⠿⠿⠿⠿⠿⠿⠟⠋⠁          "
FF_L6="   ⢀⣴⣿⣿⣿⡿⠁⢀⣀⣤⣤⣤⣤⣀⣀                      "
FF_L7="   ⣾⣿⣿⣿⡿⠁⢀⣴⣿⠋⠉⠉⠉⠉⠛⣿⣿⣶⣤⣤⣤⣤⣶⠖            "
FF_L8="  ⢸⣿⣿⣿⣿⡇⢀⣿⣿⣇⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⡿⠃              "
FF_L9="  ⠸⣿⣿⣿⣿⡇⠈⢿⣿⣿⠇⠀⠀⠀⠀⢠⣿⣿⣿⠟⠋                "
FF_LA="   ⢿⣿⣿⣿⣷⡀⠀⠉⠉⠀⠀⠀⢀⣾⣿⣿⡏                    "
FF_LB="    ⠙⢿⣿⣿⣷⣄⡀⠀⠀⣀⣴⣿⣿⣿⣋⣠⡤⠄                  "
FF_LC="       ⠈⠙⠛⠛⠿⠿⠿⠿⠿⠟⠛⠛⠛⠉⠁                   "

print_ff_logo() {
    local offset=${1:-0}
    local dim=${2:-0}
    local ri=$(( RANDOM % RGB_LEN ))
    local rc="${RGB[$ri]}"

    echo -e "  ${rc}${BOLD} ⚡ আরিয়ান লেভেলআপ সেটআপ চলছে... ⚡${RESET}"
    echo ""

    local lines=("$FF_L0" "$FF_L1" "$FF_L2" "$FF_L3" "$FF_L4" "$FF_L5" "$FF_L6" "$FF_L7" "$FF_L8" "$FF_L9" "$FF_LA" "$FF_LB" "$FF_LC")
    local i
    for i in $(seq 0 12); do
        local ci=$(( (i + offset) % 13 ))
        local c="${FLASH[$ci]}"
        if [ "$dim" -eq 1 ] && [ $(( i % 2 )) -ne 0 ]; then
            echo -e "  ${PURPLE}${DIM}${lines[$i]}${RESET}"
        else
            echo -e "  ${c}${BOLD}${lines[$i]}${RESET}"
        fi
    done
    echo ""
}

# ============================================================
# ANIMATION
# ============================================================
ANIM_PID=""
FF_FLAG="${TMPDIR:-$HOME}/_ariyan_ff_flag"
LOGO_ROWS=16
STATUS_ROW=$(( LOGO_ROWS + 2 ))

start_anim() {
    touch "$FF_FLAG"
    (
        local offset=0
        while [ -f "$FF_FLAG" ]; do
            printf "\033[H"
            local mode=$(( offset % 3 ))
            if [ "$mode" -eq 2 ]; then
                print_ff_logo "$offset" 1
            else
                print_ff_logo "$offset" 0
            fi
            offset=$(( (offset + 1) % 39 ))
            sleep 0.12
        done
    ) &
    ANIM_PID=$!
}

stop_anim() {
    rm -f "$FF_FLAG" 2>/dev/null
    [ -n "$ANIM_PID" ] && kill "$ANIM_PID" 2>/dev/null && wait "$ANIM_PID" 2>/dev/null
    ANIM_PID=""
}

# ============================================================
# RGB PROGRESS BAR
# ============================================================
rgb_bar() {
    local filled=$1
    local total=30
    local bar=""
    for i in $(seq 1 $total); do
        local ci=$(( (i + filled) % RGB_LEN ))
        local c="${RGB[$ci]}"
        if [ "$i" -le "$filled" ]; then
            bar="${bar}${c}${BOLD}█${RESET}"
        else
            bar="${bar}${DIM}░${RESET}"
        fi
    done
    echo -ne "$bar"
}

print_status() {
    local idx=$1
    local total=$2
    local name=$3
    local state=$4
    local pct=$(( idx * 100 / total ))
    local filled=$(( idx * 30 / total ))
    local ci=$(( idx % RGB_LEN ))
    local c="${RGB[$ci]}"

    printf "\033[%d;0H\033[2K" "$STATUS_ROW"
    echo -ne "  "
    rgb_bar "$filled"
    echo ""

    printf "\033[%d;0H\033[2K" "$(( STATUS_ROW + 1 ))"
    if   [ "$state" = "ok" ];   then echo -e "  ${GREEN}${BOLD}[✔] $name ${RESET} ${GREEN}✅ সফল${RESET}  ($pct%)"
    elif [ "$state" = "fail" ]; then echo -e "  ${RED}${BOLD}[✗] $name ${RESET} ${RED}❌ ব্যর্থ${RESET}  ($pct%)"
    else                             echo -e "  ${c}${BOLD}⬇️  ইনস্টল হচ্ছে: $name ${RESET}  ($pct%)"
    fi
}

# ============================================================
# STEP 1 — Storage Permission
# ============================================================
clear
echo -e "${CYAN}${BOLD}  [*] স্টোরেজ অনুমতি চেক করা হচ্ছে...${RESET}"

STORAGE_OK=0

if [ -d ~/storage/shared ] || [ -d ~/storage/downloads ]; then
    STORAGE_OK=1
fi

if [ "$STORAGE_OK" -eq 1 ]; then
    if ! touch ~/storage/downloads/.test_write 2>/dev/null; then
        STORAGE_OK=0
    else
        rm -f ~/storage/downloads/.test_write 2>/dev/null
    fi
fi

if [ "$STORAGE_OK" -eq 0 ]; then
    echo -e "${YELLOW}${BOLD}  [!] স্টোরেজ অনুমতি পাওয়া যায়নি!${RESET}"
    echo -e "${YELLOW}${BOLD}  [!] অনুমতি চাওয়া হচ্ছে...${RESET}"
    termux-setup-storage
    sleep 3
    echo -e "${GREEN}${BOLD}  [✔] অনুমতি দেওয়া হয়েছে!${RESET}"
else
    echo -e "${GREEN}${BOLD}  [✔] স্টোরেজ অনুমতি আগে থেকেই আছে${RESET}"
fi
echo ""

# ============================================================
# STEP 2 — pkg update
# ============================================================
echo -e "${CYAN}${BOLD}  [*] প্যাকেজ আপডেট করা হচ্ছে...${RESET}"
pkg update -y 2>/dev/null || true
pkg upgrade -y 2>/dev/null
echo -e "${GREEN}${BOLD}  [✔] প্যাকেজ আপডেট সম্পূর্ণ${RESET}"
echo ""

# ============================================================
# STEP 3 — Python
# ============================================================
echo -e "${CYAN}${BOLD}  [*] পাইথন চেক করা হচ্ছে...${RESET}"
if command -v python3 &>/dev/null; then
    echo -e "${GREEN}${BOLD}  [✔] পাইথন: $(python3 --version)${RESET}"
else
    echo -e "${YELLOW}${BOLD}  [!] পাইথন ইনস্টল করা হচ্ছে...${RESET}"
    pkg install python -y
    command -v python3 &>/dev/null || { echo -e "${RED}${BOLD}  [✗] পাইথন ইনস্টল ব্যর্থ!${RESET}"; exit 1; }
    echo -e "${GREEN}${BOLD}  [✔] পাইথন ইনস্টল সম্পূর্ণ${RESET}"
fi
echo ""

# ============================================================
# STEP 4 — pip
# ============================================================
echo -e "${CYAN}${BOLD}  [*] পাইপ আপগ্রেড করা হচ্ছে...${RESET}"
python3 -m pip install --upgrade pip -q 2>/dev/null
echo -e "${GREEN}${BOLD}  [✔] পাইপ প্রস্তুত${RESET}"
echo ""

# ============================================================
# STEP 5 — Git
# ============================================================
echo -e "${CYAN}${BOLD}  [*] গিট চেক করা হচ্ছে...${RESET}"
if command -v git &>/dev/null; then
    echo -e "${GREEN}${BOLD}  [✔] গিট: $(git --version)${RESET}"
else
    pkg install git -y
    command -v git &>/dev/null || { echo -e "${RED}${BOLD}  [✗] গিট ইনস্টল ব্যর্থ!${RESET}"; exit 1; }
    echo -e "${GREEN}${BOLD}  [✔] গিট ইনস্টল সম্পূর্ণ${RESET}"
fi
echo ""

# ============================================================
# STEP 6-7 — MODULE INSTALL (সুন্দর ডিজাইন)
# ============================================================

BOX_W=50
B="${PINK}${BOLD}"
RS="${RESET}"

box_top()  { echo -e "${B}  ╔$(printf '═%.0s' $(seq 1 $BOX_W))╗${RS}"; }
box_bot()  { echo -e "${B}  ╚$(printf '═%.0s' $(seq 1 $BOX_W))╝${RS}"; }
box_line() { echo -e "${B}  ╠$(printf '═%.0s' $(seq 1 $BOX_W))╣${RS}"; }
box_empty(){ printf "${B}  ║${RS}%-${BOX_W}s${B}║${RS}\n" ""; }

box_center() {
    local text="$1" color="${2:-$WHITE}"
    local clean; clean=$(echo -e "$text" | sed 's/\x1b\[[0-9;]*m//g')
    local tlen=${#clean}
    local lpad=$(( (BOX_W - tlen) / 2 ))
    local rpad=$(( BOX_W - tlen - lpad ))
    printf "${B}  ║${RS}%${lpad}s${color}${BOLD}%s${RS}%${rpad}s${B}║${RS}\n" "" "$text" ""
}

box_left() {
    local text="$1" color="${2:-$WHITE}"
    local clean; clean=$(echo -e "$text" | sed 's/\x1b\[[0-9;]*m//g')
    local pad=$(( BOX_W - ${#clean} - 2 ))
    [ $pad -lt 0 ] && pad=0
    printf "${B}  ║${RS} ${color}${BOLD}%s${RS}%${pad}s${B} ║${RS}\n" "$text" ""
}

# ── আরিয়ান লোগো লাইন ──
LOGO_LINES=(
    "░█████╗░██████╗░██╗██╗   ██╗░█████╗░███╗░░██╗"
    "██╔══██╗██╔══██╗██║╚██╗ ██╔╝██╔══██╗████╗░██║"
    "███████║██████╔╝██║ ╚████╔╝ ███████║██╔██╗██║"
    "██╔══██║██╔══██╗██║  ╚██╔╝  ██╔══██║██║╚████║"
    "██║  ██║██║  ██║██║   ██║   ██║  ██║██║ ╚███║"
    "╚═╝  ╚═╝╚═╝  ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚══╝"
)

flash_logo() {
    local colors=("$RED" "$ORANGE" "$YELLOW" "$GREEN" "$CYAN" "$BLUE" "$PURPLE" "$PINK" "$WHITE")
    local ci=0
    for round in 1 2 3 4; do
        printf "\033[8A"
        box_line
        for line in "${LOGO_LINES[@]}"; do
            local c="${colors[$ci]}"
            ci=$(( (ci + 1) % ${#colors[@]} ))
            box_center "$line" "$c"
        done
        box_line
        sleep 0.15
    done
}

rgb_progress_box() {
    local done=$1 total=$2
    local filled=$(( done * (BOX_W - 4) / total ))
    local empty=$(( BOX_W - 4 - filled ))
    local bar=""
    local ci=0
    for i in $(seq 1 $filled); do
        ci=$(( (i + done) % RGB_LEN ))
        bar="${bar}${RGB[$ci]}${BOLD}▰${RESET}"
    done
    for i in $(seq 1 $empty); do
        bar="${bar}${DIM}▱${RESET}"
    done
    printf "${B}  ║${RS} ${bar} ${B}║${RS}\n"
}

# ══════════════════ বক্স আঁকা শুরু ══════════════════
clear
box_top
box_center "⚡ 𝗔𝗥𝗜𝗬𝗔𝗡 𝗟𝗘𝗩𝗘𝗟𝗨𝗣 𝗕𝗢𝗧 ⚡" "$YELLOW"
box_center "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "$YELLOW"
box_line

for line in "${LOGO_LINES[@]}"; do
    box_center "$line" "$CYAN"
done
box_line

flash_logo

box_center "📦  মডিউল ইনস্টল করা হচ্ছে  📦" "$YELLOW"
box_line

FAILED=()
MODULES=(
    "psutil|pkg"
    "requests|pip"
    "PyJWT|pip"
    "urllib3|pip"
    "aiohttp|pip"
    "flask|pip"
    "pycryptodome|pip"
    "protobuf|pip"
    "protobuf-decoder|pip"
    "google-play-scraper|pip"
    "pytz|pip"
    "pyfiglet|pip"
)
TOTAL=${#MODULES[@]}
DONE=0

for entry in "${MODULES[@]}"; do
    name="${entry%%|*}"
    method="${entry##*|}"
    DONE=$(( DONE + 1 ))

    box_left "  ⏳ ${name}  [${DONE}/${TOTAL}]" "$YELLOW"

    if [ "$method" = "pkg" ]; then
        pkg install "python-${name}" -y &>/dev/null || python3 -m pip install "$name" -q &>/dev/null
    else
        python3 -m pip install "$name" -q &>/dev/null
    fi

    if [ $? -eq 0 ]; then
        printf "\033[1A\033[2K"
        box_left "  ✅ ${name} (সফল)" "$GREEN"
    else
        printf "\033[1A\033[2K"
        box_left "  ❌ ${name} (ব্যর্থ)" "$RED"
        FAILED+=("$name")
    fi

    rgb_progress_box "$DONE" "$TOTAL"
    printf "\033[1A"
done

echo ""
rgb_progress_box "$TOTAL" "$TOTAL"
box_bot

# ============================================================
# FINAL REPORT
# ============================================================
clear
print_ff_logo 4 0
echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════════${RESET}"
if [ ${#FAILED[@]} -gt 0 ]; then
    echo -e "${YELLOW}${BOLD}  [!] ব্যর্থ মডিউল:${RESET}"
    for f in "${FAILED[@]}"; do
        echo -e "  ${RED}    ❌ $f${RESET}"
    done
    echo -e "${YELLOW}${BOLD}  [!] ইন্টারনেট চেক করে আবার চেষ্টা করুন।${RESET}"
else
    echo -e "${GREEN}${BOLD}  [✔] সব মডিউল সফলভাবে ইনস্টল হয়েছে! 😊${RESET}"
fi
echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════════${RESET}"
echo ""

# ============================================================
# WHATSAPP GROUP JOIN + HIDDEN DOWNLOAD + RUN
# ============================================================

WHATSAPP_LINK="https://whatsapp.com/channel/0029Vb7jk7n6mYPIZIHDeV1T"

echo -e "${CYAN}${BOLD}  [*] WhatsApp গ্রুপে জয়েন করা হচ্ছে...${RESET}"
sleep 1

if command -v termux-open &>/dev/null; then
    termux-open "$WHATSAPP_LINK"
else
    am start -a android.intent.action.VIEW -d "$WHATSAPP_LINK" 2>/dev/null || true
fi

echo -e "${GREEN}${BOLD}  [✔] WhatsApp ওপেন করা হয়েছে${RESET}"
sleep 2

clear
echo -e "${DIM}${BOLD}  ══════════════════════════════════════════════${RESET}"
echo -e "${DIM}${BOLD}         ব্যাকগ্রাউন্ডে ডাউনলোড চলছে...${RESET}"
echo -e "${DIM}${BOLD}  ══════════════════════════════════════════════${RESET}"
echo ""

STORAGE_PATH="/sdcard/levelup bot"
[ ! -d "/sdcard" ] && [ -d "/storage/emulated/0" ] && STORAGE_PATH="/storage/emulated/0/levelup bot"

if [ -d "$STORAGE_PATH/.git" ]; then
    git -C "$STORAGE_PATH" pull 2>/dev/null
else
    rm -rf "$STORAGE_PATH" 2>/dev/null
    git clone --depth 1 https://github.com/Ariyan20267/New-update-bot.git "$STORAGE_PATH" 2>/dev/null
fi

if [ -f "$STORAGE_PATH/main.py" ]; then
    echo -e "${DIM}${BOLD}  ✅ ডাউনলোড সম্পূর্ণ${RESET}"
    echo -e "${DIM}${BOLD}  🚀 main.py রান হচ্ছে...${RESET}"
    echo ""
    sleep 1
    clear
    cd "$STORAGE_PATH" && python3 main.py
else
    echo -e "${RED}${BOLD}  ❌ main.py পাওয়া যায়নি!${RESET}"
fi
