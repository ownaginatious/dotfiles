{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../_shared/configuration.nix
    ];

  boot.kernelParams = [
     "video=HDMI-A-1:e"
     "drm.edid_firmware=HDMI-A-1:edid/fake-edid.bin"
  ];
  hardware.firmware = [
  (
    pkgs.runCommand "edid.bin" { } ''
      mkdir -p $out/lib/firmware/edid
      cp ${/edid/fake-edid.bin} $out/lib/firmware/edid/fake-edid.bin
    ''
  )];

  networking.hostName = "heavy-node";

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true; # Necessary for Wayland.
  };

  services.greetd.settings.default_session = {
    command = "sway";
    user = "dillon";
  };

  services.flatpak.enable = true;
  xdg = {
    portal = {
      config.common.default = "*";
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-wlr
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };

  users.users.dillon.extraGroups = lib.mkAfter [
    "cdrom"
    "docker"
  ];

  environment.systemPackages = lib.mkAfter (with pkgs; [
    ethtool
    ffmpeg
    xwayland-satellite
  ]);

  services.openssh.enable = true;
  services.avahi.enable = true;

  services.syncthing = {
    enable = true;
    group = "users";
    user = "dillon";
    dataDir = "/sync/data";
    configDir = "/sync/config";
  };

  # Custom systemd service to enable WoL.
  systemd.services.enable-wol = {
    description = "Enable Wake-on-LAN on boot";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/ethtool -s enp5s0 wol g";
    };
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}

