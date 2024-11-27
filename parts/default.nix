{
  imports = [
    ../systems # the host systems configurations

    ./checks # custom checks that are devised to test if the system is working as expected
    ./lib # the lib that is used in the system
    ./modules # nixos and home-manager modules
    ./overlays # nixpkgs overlays for custom packages and patches
    ./packages # our custom packages provided by the flake
    ./programs # programs that run in the dev shell
    ./templates # programing templates for the quick setup of new programing environments

    ./args.nix # the base args that is passed to the flake
  ];
}
