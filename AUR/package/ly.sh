#!/bin/bash

# Exit on error
set -e

# Remove GNOME and GDM
sudo pacman -Rs --noconfirm gnome gdm

# Install ly display manager
sudo pacman -S --noconfirm ly

# Enable ly service
sudo systemctl enable ly.service

# Optionally, start ly immediately (uncomment if desired)
# sudo systemctl start ly.service

echo "Gnome and GDM removed. Ly installed and enabled."

