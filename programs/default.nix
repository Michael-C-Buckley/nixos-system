{...}: {
  imports = [
    ./hyprland.nix
    ./winbox.nix
  ];

  programs.zsh.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
}
