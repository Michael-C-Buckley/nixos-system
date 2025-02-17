{ pkgs, ... }: {
  users.users.michael.packages = with pkgs; [
    swaylock

    # System Utilities
    networkmanagerapplet
    cpu-x
    pavucontrol     # Pulse Volume control
    gparted
    gammastep       # Redshift
    wofi            # Wayland launcher
    wireshark

    # Communication
    librewolf
    ungoogled-chromium
    signal-desktop
    vesktop
    kotatogram-desktop
    tor-browser

    # Media
    vlc
    gimp
    zathura               # PDF Viewer
    sxiv                  # Simple photo viewer

    # Terminals
    ghostty

    # Productivity
    meld
    obsidian
    libreoffice
    kdePackages.kalgebra  # Calculator
    # zed-editor # Builds too often and doesn't cache

    # Virtualization
    tigervnc
  ];
}
