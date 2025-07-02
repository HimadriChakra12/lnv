mkdir ~/temp

sudo pacman -S --needed base-devel git

echo "Installing pikaur...."
git clone https://aur.archlinux.org/pikaur.git ~/temp/pikaur
cd ~/temp/pikaur
makepkg -fsri
echo "Installed pikaur...."

echo "Installing yay...."
git clone https://aur.archlinux.org/yay-bin.git ~/temp/yay
cd ~/temp/yay
makepkg -si
echo "Installed yay...."

echo "Getting Dotfiles"
git clone https://github.com/HimadriChakra12/.dotfiles.git ~/.dotfiles

echo "Linking Dotfiles"
jq -c '.[]' "$HOME/.dotfiles/dotfiles.json" | while read -r item; do
  name=$(jq -r '.name' <<< "$item")
  source=$(jq -r '.source' <<< "$item")
  target=$(jq -r '.target' <<< "$item")

  echo "Linking $name..."
  ln -sf "$HOME/$source" "$(eval echo "$target")"
done

echo "Installer...."
declare -A INSTALLERS=(
  [yay]="yay -S --noconfirm"
  [npm]="npm install -g"
  [pip]="pip install"
  [cargo]="cargo install"
)

for manager in "${!INSTALLERS[@]}"; do
  packages=($(jq -r --arg mgr "$manager" '.[$mgr][]?' "$CONFIG"))
  
  if [[ ${#packages[@]} -gt 0 ]]; then
    if ! command -v "$manager" &>/dev/null; then
      echo "$manager not installed."
      continue
    fi
    echo "Installing ${#packages[@]} packages with $manager..."
    ${INSTALLERS[$manager]} "${packages[@]}"
  fi
done

