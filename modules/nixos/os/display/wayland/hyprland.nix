{
  lib,
  pkgs,
  config,
  inputs',
  ...
}: let
  inherit (lib) mkIf isWayland;

  env = config.modules.environment;
in {
  # disables Nixpkgs Hyprland module to avoid conflicts
  disabledModules = ["programs/hyprland.nix"];

  config = mkIf (isWayland config && env.desktop == "Hyprland" && pkgs.stdenv.isLinux) {
    services.xserver.displayManager.sessionPackages = [inputs'.hyprland.packages.default];

    xdg.portal.extraPortals = [
      inputs'.xdg-portal-hyprland.packages.xdg-desktop-portal-hyprland
    ];
  };
}