# Somewhere to keep a closer eye on this content
{lib, ...}: 
lib.warn "⚠️ Python 2.7 is enabled"
{
  nixpkgs.config.permittedInsecurePackages = [
    "python-2.7.18.8" # I haven't figured out what wants this yet
  ];
}