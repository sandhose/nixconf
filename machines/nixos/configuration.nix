# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
      ../../common
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.zfs.requestEncryptionCredentials = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.hostId = "4caf91fa";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking.hosts = {
    "127.0.0.1" = ["scraping.obs.coe.int" "scraping-staging.obs.coe.int"];
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    google-chrome
    steam
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.fwupd.enable = true;

  # services.tcsd.enable = true;

  services.zfs = {
    autoScrub = {
      enable = true;
      interval = "daily";
    };
    autoSnapshot = {
      enable = true;
      flags = "-k -p --utc";
      frequent = 8;
    };
    trim = {
      enable = true;
      interval = "daily";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  services.xserver = {
    enable = true;
    displayManager.gdm = {
      enable = true;
    };
    desktopManager.gnome3 = {
      enable = true;
    } ;
    libinput.enable = true;
    layout = "fr";
    xkbModel = "pc105";
    xkbVariant = "mac";
  };

  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
  };

  docker-containers = {
    traefik = {
      cmd = [
        "--api.insecure=true"
        "--providers.docker"
        "--providers.docker.defaultRule=Host(`{{ trimPrefix `/` .Name }}.localhost`)"
      ];
      volumes = [
        "/var/run/docker.sock:/var/run/docker.sock"
      ];
      image = "library/traefik:v2.1";
      ports = [
        "80:80"
      ];
      extraDockerOptions = [
        "--label=traefik.http.services.traefik.loadbalancer.server.port=8080"
      ];
    };
  };

  users = {
    groups.sandhose = { };
    users.sandhose = {
      description = "Quentin Gliech";
      isNormalUser = true;
      group = "sandhose";
      home = "/home/sandhose";
      shell = pkgs.zsh;
      extraGroups = [ "wheel" "docker" ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKI3JrkOofavtPW8jV/GYM5Mv1gn/h732JPm82SGGj50 sandhose@sandhose-laptop"
      ];
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?

}
