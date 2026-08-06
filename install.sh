#!/usr/bin/env bash

#############################################
# Manjaro Gaming Monitor
# Installateur
# Version 0.1 Alpha
#############################################

clear

echo "=========================================="
echo "      Manjaro Gaming Monitor"
echo "           Installateur"
echo "=========================================="
echo

# Vérification Linux
if [[ "$(uname)" != "Linux" ]]; then
    echo "❌ Ce programme fonctionne uniquement sous Linux."
    exit 1
fi

echo "✔ Linux détecté"

# Vérification Manjaro
if [[ -f /etc/manjaro-release ]]; then
    echo "✔ Manjaro détecté"
else
    echo "⚠ Distribution différente de Manjaro"
fi

# Vérification KDE
if [[ "$XDG_CURRENT_DESKTOP" == *KDE* ]]; then
    echo "✔ KDE Plasma détecté"
else
    echo "⚠ KDE non détecté"
fi

echo
echo "Installation des dépendances..."
echo

packages=(
conky
lm_sensors
curl
git
jq
inxi
mangohud
)

missing=()

for pkg in "${packages[@]}"; do
    if pacman -Qi "$pkg" &>/dev/null; then
        echo "✔ $pkg"
    else
        echo "➜ Installation de $pkg"
        missing+=("$pkg")
    fi
done

if (( ${#missing[@]} > 0 )); then
    sudo pacman -S --needed "${missing[@]}"
fi

echo
echo "Installation terminée."
