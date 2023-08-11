{
  description = "Isabel's dotfiles";

  outputs = {
    self,
    nixpkgs,
    flake-parts,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} ({withSystem, ...}: {
      systems = [
        "x86_64-linux"
      ];

      imports = [
        {config._module.args._inputs = inputs // {inherit (inputs) self;};}

        inputs.flake-parts.flakeModules.easyOverlay

        ./lib/makesys.nix # args that is passsed to the flake, moved away from the main file
      ];

      flake = let
        # extended nixpkgs lib, contains my custom functions
        lib = import ./lib {inherit nixpkgs inputs;};
      in {
        # entry-point for nixos configurations
        nixosConfigurations = import ./hosts {inherit nixpkgs self lib withSystem;};
      };

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        imports = [{_module.args.pkgs = config.legacyPackages;}];

        # provide the formatter for nix fmt
        formatter = pkgs.alejandra;
      };
    });

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Nix helper
    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # remote ssh vscode server
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Automated, pre-built packages for Wayland
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix gaming packages
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Rust overlay
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Language server
    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    # Amazing themeing
    catppuccin.url = "github:isabelroses/ctp-nix";

    # Secrets
    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };

    # Hyprland packages
    hyprland.url = "github:hyprwm/Hyprland";

    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xdg-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secure-boot on nixos
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # mailserver on nixos
    simple-nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/master";

    # nushell scripts
    nu_scripts = {
      type = "git";
      url = "https://github.com/nushell/nu_scripts";
      submodules = true;
      flake = false;
    };

    # my nvim conf
    isabel-nvim = {
      type = "git";
      url = "https://github.com/isabelroses/nvim";
      submodules = false;
      flake = false;
    };

    # nur's
    nur.url = "github:nix-community/nur";
    bella-nur.url = "github:isabelroses/nur";
    nekowinston-nur.url = "github:nekowinston/nur";
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://hyprland.cachix.org"
      "https://isabelroses.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "isabelroses.cachix.org-1:mXdV/CMcPDaiTmkQ7/4+MzChpOe6Cb97njKmBQQmLPM="
    ];
  };
}
