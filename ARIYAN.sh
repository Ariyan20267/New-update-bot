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
WHITE="\033[97m"
ORANGE="\033[38;5;214m"

RGB=(
    "\033[38;5;196m"
    "\033[38;5;202m"
    "\033[38;5;208m"
    "\033[38;5;214m"
    "\033[38;5;220m"
    "\033[38;5;226m"
    "\033[38;5;154m"
    "\033[38;5;118m"
    "\033[38;5;51m"
    "\033[38;5;45m"
    "\033[38;5;21m"
    "\033[38;5;57m"
    "\033[38;5;93m"
    "\033[38;5;201m"
    "\033[38;5;198m"
)
RGB_LEN=15

FLASH=("$RED" "$ORANGE" "$YELLOW" "$WHITE" "$ORANGE" "$RED" "$YELLOW" "$ORANGE" "$WHITE" "$RED" "$YELLOW" "$ORANGE" "$RED")

# ============================================================
# FREE FIRE LOGO — direct characters (no \u escapes)
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

    echo -e "  ${rc}${BOLD} █████╗ ██████╗ ██╗██╗   ██╗ █████╗ ███╗  ██╗${RESET}"
    echo ""

    local lines=("$FF_L0" "$FF_L1" "$FF_L2" "$FF_L3" "$FF_L4" "$FF_L5" "$FF_L6" "$FF_L7" "$FF_L8" "$FF_L9" "$FF_LA" "$FF_LB" "$FF_LC")
    local i
    for i in $(seq 0 12); do
        local ci=$(( (i + offset) % 13 ))
        local c="${FLASH[$ci]}"
        if [ "$dim" -eq 1 ] && [ $(( i % 2 )) -ne 0 ]; then
            echo -e "  ${RED}${DIM}${lines[$i]}${RESET}"
        else
            echo -e "  ${c}${BOLD}${lines[$i]}${RESET}"
        fi
    done
    echo ""
}

# ============================================================
# ANIMATION — TMPDIR safe for Termux
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
            sleep 0.15
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
# RGB PROGRESS BAR + STATUS
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
    if   [ "$state" = "ok" ];   then echo -e "  ${GREEN}${BOLD}[✔] $name${RESET}  ($pct%)"
    elif [ "$state" = "fail" ]; then echo -e "  ${RED}${BOLD}[✗] $name FAILED${RESET}  ($pct%)"
    else                             echo -e "  ${c}${BOLD}[*] Installing $name...${RESET}  ($pct%)"
    fi
}

# ============================================================
# STEP 1 — Storage
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
# STEP 2 — pkg update
# ============================================================
echo -e "${CYAN}${BOLD}  [*] Updating packages...${RESET}"
pkg update -y 2>/dev/null || true
pkg upgrade -y 2>/dev/null
echo -e "${GREEN}${BOLD}  [✔] Packages updated${RESET}"
echo ""

# ============================================================
# STEP 3 — Python
# ============================================================
echo -e "${CYAN}${BOLD}  [*] Checking Python...${RESET}"
if command -v python3 &>/dev/null; then
    echo -e "${GREEN}${BOLD}  [✔] Python: $(python3 --version)${RESET}"
else
    echo -e "${YELLOW}${BOLD}  [!] Installing Python...${RESET}"
    pkg install python -y
    command -v python3 &>/dev/null || { echo -e "${RED}${BOLD}  [✗] Python install failed!${RESET}"; exit 1; }
    echo -e "${GREEN}${BOLD}  [✔] Python installed${RESET}"
fi
echo ""

# ============================================================
# STEP 4 — pip
# ============================================================
echo -e "${CYAN}${BOLD}  [*] Upgrading pip...${RESET}"
python3 -m pip install --upgrade pip -q 2>/dev/null
echo -e "${GREEN}${BOLD}  [✔] pip ready${RESET}"
echo ""

# ============================================================
# STEP 5 — Git
# ============================================================
echo -e "${CYAN}${BOLD}  [*] Checking Git...${RESET}"
if command -v git &>/dev/null; then
    echo -e "${GREEN}${BOLD}  [✔] Git: $(git --version)${RESET}"
else
    pkg install git -y
    command -v git &>/dev/null || { echo -e "${RED}${BOLD}  [✗] Git install failed!${RESET}"; exit 1; }
    echo -e "${GREEN}${BOLD}  [✔] Git installed${RESET}"
fi
echo ""

# ============================================================
# STEP 6-7 — MODULE INSTALL with FF LOGO + RGB PROGRESS
# ============================================================
clear
printf "\033[?25l"
for i in $(seq 1 $(( STATUS_ROW + 5 ))); do echo ""; done
printf "\033[H"

start_anim
sleep 0.5

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
        pkg install "python-${name}" -y &>/dev/null || python3 -m pip install "$name" -q &>/dev/null
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
printf "\033[?25h"

# ============================================================
# FINAL REPORT
# ============================================================
clear
print_ff_logo 4 0
echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════${RESET}"
if [ ${#FAILED[@]} -gt 0 ]; then
    echo -e "${YELLOW}${BOLD}  [!] Failed modules:${RESET}"
    for f in "${FAILED[@]}"; do
        echo -e "  ${RED}    ✗ $f${RESET}"
    done
    echo -e "${YELLOW}${BOLD}  [!] Check internet and retry.${RESET}"
else
    echo -e "${GREEN}${BOLD}  [✔] All modules installed successfully!${RESET}"
fi
echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════${RESET}"
echo ""

# ============================================================
# STEP 9 — Clone repo & run main.py
# ============================================================
REPO_URL="https://github.com/Ariyan20267/New-update-bot.git"
REPO_DIR="$HOME/$(basename "$REPO_URL" .git)"

echo -e "${CYAN}${BOLD}  [*] Cloning repository...${RESET}"
echo -e "${DIM}      $REPO_URL${RESET}"
echo ""

if [ -d "$REPO_DIR/.git" ]; then
    echo -e "${YELLOW}${BOLD}  [!] Repo exists, pulling latest...${RESET}"
    git -C "$REPO_DIR" pull 2>/dev/null
    echo -e "${GREEN}${BOLD}  [✔] Repo updated${RESET}"
else
    git clone "$REPO_URL" "$REPO_DIR"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}${BOLD}  [✔] Repo cloned${RESET}"
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
    echo -e "${GREEN}${BOLD}       Setup complete! Launching...${RESET}"
    echo -e "${BLUE}${BOLD}  ══════════════════════════════════════════${RESET}"
    echo ""
    sleep 1
    cd "$REPO_DIR" && python3 main.py
else
    echo -e "${RED}${BOLD}  [✗] main.py not found in repo!${RESET}"
    echo -e "${CYAN}      Run: python3 $MAIN_PATH${RESET}"
fi
