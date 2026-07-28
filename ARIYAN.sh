#!/data/data/com.termux/files/usr/bin/bash

# ============================================================
#         ARIYAN FREE FIRE - TERMUX AUTO SETUP (IMPROVED)
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

# নতুন আরিয়ান কালার প্যালেট (রেইনবো + নিওন)
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

    echo -e "  ${rc}${BOLD} ⚡ আরিয়ান সেটআপ চলছে... ⚡${RESET}"
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
# ANIMATION (আরও স্মুথ ও সুন্দর)
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
            sleep 0.12  # আগের থেকে দ্রুততর
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
# RGB PROGRESS BAR (নতুন ডিজাইন)
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
# STEP 6-7 — MODULE INSTALL (নতুন আলাদা ডিজাইন)
# ============================================================

BOX_W=50  # ডিজাইনের জন্য বড় বক্স
B="${PINK}${BOLD}"  # নতুন বর্ডার কালার
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

# ── নতুন আরিয়ান লোগো (৭ লাইনের) ──
LOGO_LINES=(
    "░█████╗░██████╗░██╗██╗   ██╗░█████╗░███╗░░██╗"
    "██╔══██╗██╔══██╗██║╚██╗ ██╔╝██╔══██╗████╗░██║"
    "███████║██████╔╝██║ ╚████╔╝ ███████║██╔██╗██║"
    "██╔══██║██╔══██╗██║  ╚██╔╝  ██╔══██║██║╚████║"
    "██║  ██║██║  ██║██║   ██║   ██║  ██║██║ ╚███║"
    "╚═╝  ╚═╝╚═╝  ╚═╝╚═╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚══╝"
)

# ── লোগো ফ্ল্যাশ (নতুন রং) ──
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

# ── RGB প্রোগ্রেস বার (বক্সের ভেতরে, নতুন ডিজাইন) ──
rgb_progress_box() {
    local done=$1 total=$2
    local filled=$(( done * (BOX_W - 4) / total ))
    local empty=$(( BOX_W - 4 - filled ))
    local bar=""
    local ci=0
    for i in $(seq 1 $filled); do
        ci=$(( (i + done) % RGB_LEN ))
        bar="${bar}${RGB[$ci]}${BOLD}▰${RESET}"  # ▰ ব্যবহার করা হয়েছে
    done
    for i in $(seq 1 $empty); do
        bar="${bar}${DIM}▱${RESET}"  # ▱ ব্যবহার করা হয়েছে
    done
    printf "${B}  ║${RS} ${bar} ${B}║${RS}\n"
}

# ══════════════════ বক্স আঁকা শুরু ══════════════════
clear
box_top
box_center "⚡ 𝗔𝗥𝗜𝗬𝗔𝗡 𝗕𝗢𝗧 𝗦𝗘𝗧𝗨𝗣 ⚡" "$YELLOW"
box_center "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" "$YELLOW"
box_line

# লোগো প্রথমবার আঁকো
for line in "${LOGO_LINES[@]}"; do
    box_center "$line" "$CYAN"
done
box_line

# লোগো ফ্ল্যাশ অ্যানিমেশন
flash_logo

# ইনস্টল হেডার
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

    # ⏳ ইনস্টল হচ্ছে
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

    # RGB প্রোগ্রেস বার আপডেট
    rgb_progress_box "$DONE" "$TOTAL"
    printf "\033[1A"
done

# শেষ বার পূর্ণ দেখাও
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
# STEP 9 — Clone repo & run main.py
# ============================================================
REPO_URL="https://github.com/Ariyan20267/New-update-bot.git"
REPO_DIR="$HOME/$(basename "$REPO_URL" .git)"

echo -e "${CYAN}${BOLD}  [*] রিপোজিটরি ক্লোন করা হচ্ছে...${RESET}"
echo -e "${DIM}      $REPO_URL${RESET}"
echo ""

if [ -d "$REPO_DIR/.git" ]; then
    echo -e "${YELLOW}${BOLD}  [!] রেপো ইতিমধ্যে আছে, আপডেট করা হচ্ছে...${RESET}"
    git -C "$REPO_DIR" pull 2>/dev/null
    echo -e "${GREEN}${BOLD}  [✔] রেপো আপডেট সম্পূর্ণ${RESET}"
else
    git clone "$REPO_URL" "$REPO_DIR"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}${BOLD}  [✔] রেপো ক্লোন সম্পূর্ণ${RESET}"
    else
        echo -e "${RED}${BOLD}  [✗] ক্লোন ব্যর্থ! রেপো URL চেক করুন।${RESET}"
        exit 1
    fi
fi

echo ""
MAIN_PATH="$REPO_DIR/main.py"

if [ -f "$MAIN_PATH" ]; then
    echo -e "${GREEN}${BOLD}  [✔] main.py পাওয়া গেছে${RESET}"
    echo ""
    echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo -e "${GREEN}${BOLD}       সেটআপ সম্পূর্ণ! লঞ্চ করা হচ্ছে...${RESET}"
    echo -e "${PINK}${BOLD}    ❤️  enjoy ❤️${RESET}"
    echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════════${RESET}"
    echo ""
    sleep 1
    cd "$REPO_DIR" && python3 main.py
else
    echo -e "${RED}${BOLD}  [✗] main.py রেপোতে পাওয়া যায়নি!${RESET}"
    echo -e "${CYAN}      রান করুন: python $MAIN_PATH${RESET}"
fi
