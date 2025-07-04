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

echo "Installing Packages"
packages=(
    "qimgv"
    "ranger"
    "curl"
    "nemo"
    "rust"
    "mpv"
    "qemu"
    "spotify"
    "github-cli"
    "lazygit"
    "neovim"
    "jdownloader2"
    "qbittorrent"
    "tmux"
    "i3"
)

langs=(
    "rust"
    "cmake"
    "make"
    "gcc"
    "golang"
)
yay -S --noconfirm "${packages[@]}"


dotfiles=(
  "$HOME/.dotfiles/i3:$HOME/.config/i3"
  "$HOME/.dotfiles/gh:$HOME/.config/gh"
  "$HOME/.dotfiles/mpv:$HOME/.config/mpv"
  "$HOME/.dotfiles/nvim:$HOME/.config/nvim"
  "$HOME/.dotfiles/qimgv:$HOME/.config/qimgv"
  "$HOME/.dotfiles/wezterm:$HOME/.config/wezterm"
  "$HOME/.dotfiles/.bashrc:$HOME/.bashrc"
  "$HOME/.dotfiles/.tmux.conf:$HOME/.tmux.conf"
)

echo "Linking dotfiles..."
for entry in "${dotfiles[@]}"; do
  src="${entry%%:*}"
  tgt="${entry##*:}"
  echo "Linking $src → $tgt"
  ln -sf "$src" "$tgt"
done


