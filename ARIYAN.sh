#!/data/data/com.termux/files/usr/bin/bash

# ============================================================
#         ARIYAN FREE FIRE - TERMUX AUTO SETUP
# ============================================================

RESET="\033[0m"
BOLD="\033[1m"
DIM="\033[2m"
GREEN="\033[92m"
YELLOW="\033[93m"
CYAN="\033[96m"
RED="\033[91m"
BLUE="\033[94m"
MAGENTA="\033[95m"
WHITE="\033[97m"
ORANGE="\033[38;5;214m"

# RGB color cycle array
RGB=(
    "\033[38;5;196m"  # red
    "\033[38;5;202m"  # orange-red
    "\033[38;5;208m"  # orange
    "\033[38;5;214m"  # yellow-orange
    "\033[38;5;220m"  # yellow
    "\033[38;5;226m"  # bright yellow
    "\033[38;5;154m"  # yellow-green
    "\033[38;5;118m"  # green
    "\033[38;5;51m"   # cyan
    "\033[38;5;45m"   # sky blue
    "\033[38;5;21m"   # blue
    "\033[38;5;57m"   # indigo
    "\033[38;5;93m"   # violet
    "\033[38;5;201m"  # magenta
    "\033[38;5;198m"  # pink-red
)
RGB_LEN=15

# Flash colors for FF logo
FLASH=(
    "$RED" "$ORANGE" "$YELLOW" "$WHITE" "$ORANGE"
    "$RED" "$YELLOW" "$ORANGE" "$WHITE" "$RED"
    "$YELLOW" "$ORANGE" "$RED"
)

# ============================================================
# FREE FIRE LOGO
# ============================================================
FF_LINES=(
    "            \u2820\u28a0\u2884\u28e4                        "
    "   \u2820\u28a4\u2876\u2801\u28a0\u28b4\u28be\u281f\u280b\u2801                          "
    "  \u2820\u28b4\u28bf\u28bf\u28b4\u28bf\u281f\u280b\u2801\u2820\u2800\u2800\u2800\u2800\u2800\u2805                      "
    "  \u2830\u28bf\u28ff\u28ff\u28ff\u28ff\u28bf\u28be\u28ff\u28ff\u28ff\u28ff\u28ff\u28ff\u28ff\u28ff\u28ff\u28bf\u28b6\u28e4\u2805                "
    "\u28a0\u28be\u28ff\u281f\u281f\u280b\u2801\u2800\u2820\u2800\u28a8\u28ad\u28ff\u28ff\u28ff\u28ff\u28ff\u28ff\u28ff\u28ff\u28ff\u28ff\u28ff\u28bf\u28a4\u28a4\u28a4\u28a4\u28b4\u2802"
    "\u2801\u2809\u2801\u2800\u2820\u28b4\u28be\u28ff\u28ff\u281f\u281f\u280b\u2809\u2801\u2809\u2809\u280b\u281b\u28ff\u28ff\u28ff\u28ff\u28ff\u28ff\u281f\u280b\u2801          "
    "   \u2820\u28b4\u28ff\u28ff\u28ff\u281f\u2801\u2820\u2800\u28a4\u28a4\u28a4\u28a4\u2800\u2800                      "
    "   \u28be\u28ff\u28ff\u28ff\u281f\u2801\u2820\u28b4\u28ff\u280b\u2809\u2809\u2809\u2809\u280b\u28ff\u28ff\u28b6\u28a4\u28a4\u28a4\u28a4\u28b6\u2816            "
    "  \u2838\u28ff\u28ff\u28ff\u28ff\u2807\u2820\u28ff\u28ff\u2807\u2800\u2800\u2800\u2800\u2800\u2818\u28ff\u28ff\u28ff\u28ff\u28ff\u281f\u2803              "
    "  \u2818\u28ff\u28ff\u28ff\u28ff\u2807\u2808\u28ff\u28ff\u28ff\u2807\u2800\u2800\u2800\u2800\u2820\u28ff\u28ff\u28ff\u281f\u280b                "
    "   \u28ff\u28ff\u28ff\u28ff\u28bf\u2805\u2800\u2809\u2809\u2800\u2800\u2800\u2820\u28be\u28ff\u28ff\u2807                    "
    "    \u2809\u28ff\u28ff\u28ff\u28bf\u2824\u2805\u2800\u2800\u2820\u28b4\u28ff\u28ff\u28ff\u280b\u28a0\u2804\u2816                  "
    "       \u2808\u2809\u280b\u280b\u281f\u281f\u281f\u281f\u281f\u281f\u280b\u280b\u280b\u2809\u2801                   "
)

# ARIYAN text
print_ariyan() {
    local c="${RGB[$((RANDOM % RGB_LEN))]}"
    echo -e "  ${c}${BOLD} █████╗ ██████╗ ██╗██╗   ██╗ █████╗ ███╗  ██╗${RESET}"
}

# Print FF logo with color offset
print_ff_logo() {
    local offset=${1:-0}
    local dim=${2:-0}
    print_ariyan
    echo ""
    for i in $(seq 0 12); do
        local ci=$(( (i + offset) % 13 ))
        local c="${FLASH[$ci]}"
        if [ "$dim" -eq 1 ] && [ $(( i % 2 )) -ne 0 ]; then
            echo -e "  ${RED}${DIM}${FF_LINES[$i]}${RESET}"
        else
            echo -e "  ${c}${BOLD}${FF_LINES[$i]}${RESET}"
        fi
    done
}

# ============================================================
# ANIMATION ENGINE
# FF logo blinks on top, RGB status below
# ============================================================
ANIM_PID=""
LOGO_ROWS=16   # ariyan(1) + blank(1) + ff_logo(13) + blank(1)
STATUS_ROW=$((LOGO_ROWS + 2))

start_anim() {
    touch /tmp/_ff_on
    (
        local offset=0
        while [ -f /tmp/_ff_on ]; do
            tput cup 0 0 2>/dev/null
            local mode=$(( offset % 3 ))
            if   [ "$mode" -eq 0 ]; then print_ff_logo "$offset" 0
            elif [ "$mode" -eq 1 ]; then print_ff_logo "$offset" 0
            else                         print_ff_logo "$offset" 1
            fi
            offset=$(( (offset + 1) % 39 ))
            sleep 0.15
        done
    ) &
    ANIM_PID=$!
}

stop_anim() {
    rm -f /tmp/_ff_on 2>/dev/null
    [ -n "$ANIM_PID" ] && kill "$ANIM_PID" 2>/dev/null && wait "$ANIM_PID" 2>/dev/null
    ANIM_PID=""
}

# RGB progress bar
rgb_bar() {
    local filled=$1
    local total=$2
    local bar=""
    for i in $(seq 1 $total); do
        local ci=$(( (i + filled) % RGB_LEN ))
        local c="${RGB[$ci]}"
        if [ $i -le $filled ]; then
            bar="${bar}${c}${BOLD}█${RESET}"
        else
            bar="${bar}${DIM}░${RESET}"
        fi
    done
    echo -ne "$bar"
}

# Print status line below logo
print_status() {
    local idx=$1
    local total=$2
    local name=$3
    local state=$4   # installing | ok | fail

    tput cup $STATUS_ROW 0 2>/dev/null
    tput el 2>/dev/null
    tput cup $((STATUS_ROW+1)) 0 2>/dev/null
    tput el 2>/dev/null
    tput cup $((STATUS_ROW+2)) 0 2>/dev/null
    tput el 2>/dev/null

    tput cup $STATUS_ROW 0 2>/dev/null
    local pct=$(( idx * 100 / total ))
    local filled=$(( idx * 30 / total ))

    # RGB progress bar
    echo -ne "  "
    rgb_bar $filled 30
    echo ""

    tput cup $((STATUS_ROW+1)) 0 2>/dev/null
    local ci=$(( idx % RGB_LEN ))
    local c="${RGB[$ci]}"

    if   [ "$state" = "ok" ];          then echo -e "  ${GREEN}${BOLD}  [✔] $name${RESET}  ($pct%)"
    elif [ "$state" = "fail" ];        then echo -e "  ${RED}${BOLD}    [✗] $name FAILED${RESET}  ($pct%)"
    else                                    echo -e "  ${c}${BOLD}  [*] Installing $name...${RESET}  ($pct%)"
    fi
}

# ============================================================
# STEP 1: Storage permission
# ============================================================
clear
echo -e "${CYAN}${BOLD}  [*] Checking storage permission...${RESET}"
if [ ! -d ~/storage ]; then
    echo -e "${YELLOW}${BOLD}  [!] Requesting storage permission...${RESET}"
    termux-setup-storage
    sleep 2
fi
echo -e "${GREEN}${BOLD}  [✔] Storage OK${RESET}"
echo ""

# ============================================================
# STEP 2: pkg update
# ============================================================
echo -e "${CYAN}${BOLD}  [*] Updating packages...${RESET}"
pkg update -y 2>/dev/null || echo -e "${YELLOW}${BOLD}  [!] pkg update issue, continuing...${RESET}"
pkg upgrade -y 2>/dev/null
echo -e "${GREEN}${BOLD}  [✔] Packages updated${RESET}"
echo ""

# ============================================================
# STEP 3: Python
# ============================================================
echo -e "${CYAN}${BOLD}  [*] Checking Python...${RESET}"
if command -v python3 &>/dev/null; then
    echo -e "${GREEN}${BOLD}  [✔] Python found: $(python3 --version)${RESET}"
else
    echo -e "${YELLOW}${BOLD}  [!] Installing Python...${RESET}"
    pkg install python -y
    command -v python3 &>/dev/null || { echo -e "${RED}${BOLD}  [✗] Python install failed!${RESET}"; exit 1; }
    echo -e "${GREEN}${BOLD}  [✔] Python installed: $(python3 --version)${RESET}"
fi
echo ""

# ============================================================
# STEP 4: pip upgrade
# ============================================================
echo -e "${CYAN}${BOLD}  [*] Upgrading pip...${RESET}"
python3 -m pip install --upgrade pip -q 2>/dev/null
echo -e "${GREEN}${BOLD}  [✔] pip upgraded${RESET}"
echo ""

# ============================================================
# STEP 5: Git
# ============================================================
echo -e "${CYAN}${BOLD}  [*] Checking Git...${RESET}"
if command -v git &>/dev/null; then
    echo -e "${GREEN}${BOLD}  [✔] Git found: $(git --version)${RESET}"
else
    pkg install git -y
    command -v git &>/dev/null || { echo -e "${RED}${BOLD}  [✗] Git install failed!${RESET}"; exit 1; }
    echo -e "${GREEN}${BOLD}  [✔] Git installed${RESET}"
fi
echo ""

# ============================================================
# STEP 6-7: MODULE INSTALL — FF LOGO BLINKING + RGB PROGRESS
# ============================================================
clear
# reserve space for logo + status
for i in $(seq 1 $((STATUS_ROW + 4))); do echo ""; done

# start FF logo animation
start_anim
sleep 0.4

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

    print_status "$DONE" "$TOTAL" "$name" "installing"

    if [ "$method" = "pkg" ]; then
        pkg install "python-${name}" -y &>/dev/null
        if [ $? -ne 0 ]; then
            python3 -m pip install "$name" -q &>/dev/null
        fi
    else
        python3 -m pip install "$name" -q &>/dev/null
    fi

    if [ $? -eq 0 ]; then
        print_status "$DONE" "$TOTAL" "$name" "ok"
    else
        print_status "$DONE" "$TOTAL" "$name" "fail"
        FAILED+=("$name")
    fi
    sleep 0.35
done

stop_anim

# ============================================================
# FINAL REPORT
# ============================================================
clear
print_ff_logo 4 0
echo ""
echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════${RESET}"
if [ ${#FAILED[@]} -gt 0 ]; then
    echo -e "${YELLOW}${BOLD}  [!] Failed modules:${RESET}"
    for f in "${FAILED[@]}"; do
        echo -e "  ${RED}      ✗ $f${RESET}"
    done
    echo -e "${YELLOW}${BOLD}  [!] Check internet and retry.${RESET}"
else
    echo -e "${GREEN}${BOLD}  [✔] All modules installed successfully! 🎉${RESET}"
fi
echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════${RESET}"
echo ""

# ============================================================
# STEP 9: Clone repo & run main.py
# ============================================================
REPO_URL="https://github.com/Ariyan20267/New-update-bot.git"
REPO_DIR="$HOME/$(basename "$REPO_URL" .git)"

echo -e "${CYAN}${BOLD}  [*] Cloning repository...${RESET}"
echo -e "${DIM}  ${REPO_URL}${RESET}"
echo ""

if [ -d "$REPO_DIR/.git" ]; then
    echo -e "${YELLOW}${BOLD}  [!] Repo exists, pulling latest...${RESET}"
    git -C "$REPO_DIR" pull 2>/dev/null
    echo -e "${GREEN}${BOLD}  [✔] Repo updated${RESET}"
else
    git clone "$REPO_URL" "$REPO_DIR" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}${BOLD}  [✔] Repo cloned: $REPO_DIR${RESET}"
    else
        echo -e "${RED}${BOLD}  [✗] Clone failed! Check repo URL.${RESET}"
        exit 1
    fi
fi

echo ""
MAIN_PATH="$REPO_DIR/main.py"

if [ -f "$MAIN_PATH" ]; then
    echo -e "${GREEN}${BOLD}  [✔] main.py found${RESET}"
    echo ""
    echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════${RESET}"
    echo -e "${GREEN}${BOLD}  Setup complete! Launching main.py...${RESET}"
    echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════${RESET}"
    echo ""
    sleep 1
    cd "$REPO_DIR" && python3 main.py
else
    echo -e "${RED}${BOLD}  [✗] main.py not found in repo!${RESET}"
    echo -e "${CYAN}  Run manually: python3 $MAIN_PATH${RESET}"
fi
