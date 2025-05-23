{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "personal-vm";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  services = {
    spice-vdagentd.enable = true;
    qemuGuest.enable = true;
    flatpak.enable = true;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  users.users.dillon = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    home = "/home/dillon";
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
    waybar.enable = true;
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
     curl
     fuzzel
     git
     librewolf
     mako
     vim
     wget
  ];

  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}

