{ lib, ... }:
let
  inherit (lib.modules) mkForce;
in
{
  time.timeZone = mkForce "UTC";

  garden.device.type = "server";
}
