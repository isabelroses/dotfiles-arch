{
  config,
  lib,
  ...
}:
with lib; let
  device = config.modules.device;
in {
  config = {
    modules = {
      device = {
        type = "hybrid";
        cpu = "intel";
        gpu = null;
        hasTPM = true;
        monitors = ["eDP-1"];
        hasBluetooth = true;
        hasSound = true;
      };
      system = {
        username = "isabel";

        hostname = "hydra";

        boot = {
          loader = "systemd-boot";
          enableKernelTweaks = true;
          enableInitrdTweaks = true;
          loadRecommendedModules = true;
        };

        video.enable = true;
        sound.enable = true;
        bluetooth.enable = false;
        printing.enable = false;

        networking = {
          optimizeTcp = true;
        };

        virtualization = {
          enable = true;
          docker.enable = true;
          qemu.enable = false;
          podman.enable = false;
          distrobox.enable = true;
        };

        smb = {
          enable = true;
          media.enable = true;
          genral.enable = true;
        };
      };
      usrEnv = {
        isWayland = true;
        desktop = "Hyprland";
        useHomeManager = true;
      };
      services = {
        cloudflare = {
          enable = true;
          token = "eyJhIjoiNjA0YTQxZmY1ZDI1NzQ5MzllZmJiMWM1NWJhYzA5MGUiLCJ0IjoiN2U5MzZlMjAtODE4ZS00N2UwLWE2ZjEtYmIxOTE3NmY0ZTE4IiwicyI6IllUSXdZelJqTm1RdE5qY3lNeTAwWmpNMExUbGpOell0TmpKall6RmxPVEpsTWpkaiJ9";
        };
      };
      programs = {
        git.signingKey = "CFF897835DD77813";

        cli.enable = true;
        gui.enable = true;

        nur = {
          enable = true;
          bella = true;
        };

        default = {
          terminal = "alacritty";
          bar = "eww";
        };
        override = {};
      };
    };

    boot = {
      kernelParams =
        [
          "nohibernate"
        ]
        ++ optionals ((device.cpu == "intel") && (device.gpu != "hybrid-nv")) [
          "i915.enable_fbc=1"
          "i915.enable_psr=2"
        ];
    };

    console.earlySetup = true;
  };
}
