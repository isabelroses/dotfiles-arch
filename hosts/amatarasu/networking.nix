{
  config,
  ...
}: {
  networking = {
    # useDHCP = false;
    networkmanager.enable = true;
    hostName = "amatarasu";
  };
}