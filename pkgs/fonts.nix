{ config, pkgs, lib, ... }: let
  useFonts = config.features.pkgs.fonts;

  nerdFonts = with pkgs.nerd-fonts; lib.optionals useFonts [
    agave
    caskaydia-cove
    hurmit
    jetbrains-mono
    symbols-only
  ];
in {
  fonts.packages = with pkgs; lib.optionals useFonts [
    maple-mono
    b612
    font-awesome
    nerd-fonts.agave
  ] ++ nerdFonts;
}
