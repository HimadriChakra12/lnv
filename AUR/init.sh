mkdir ~/temp

sudo pacman -S --noconfirm ly
sudo systemctl enable ly.service
echo "Ly installed and enabled."

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
echo "Language Captain"
langs=(
    "rust"
    "cmake"
    "make"
    "gcc"
    "golang"
)
echo "Shell"
shell=(
    "ranger"
    "curl"
    "github-cli"
    "lazygit"
    "neovim"
    "tmux"
)
echo "i3"
i3=(
    "i3"
    "dunst"
    "rofi"
)
echo "Suppliments"
packages=(
    "nemo"
    "firefox"
    "qimgv"
    "mpv"
    "qemu"
    "spotify"
    "jdownloader2"
    "qbittorrent"
)


yay -S --noconfirm "${langs[@]}"
yay -S --noconfirm "${shell[@]}"
yay -S --noconfirm "${i3[@]}"
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



